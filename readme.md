# Reverse_Image_Caption

## Introduction
In this project, we implemented a "Reverse Image Caption" model—a Text-to-Image generation system—designed to synthesize realistic images from natural language descriptions.  
In this advanced generative computer vision task, we built the foundational Generative Adversarial Network (GAN) architectures from scratch, specifically exploring Deep Convolutional GANs (DC-GAN) and StackGAN architectures to compare their generative capabilities.  
Furthermore, we implemented specialized pipelines for handling text embeddings, designed Conditioning Augmentation mechanisms to ensure latent space continuity, and transformed raw text-image pairs into properly scaled tensors for adversarial training.  

## Dataset Description
The project utilizes a paired text-to-image dataset.  
Each image is accompanied by text annotations containing natural language descriptions of the visual content.  
The dataset encompasses a wide variety of specific visual attributes, providing the necessary semantic grounding for the generator to learn the complex mapping from text space to image space.  

## Feature Engineering & Preprocessing
We design a data processing and augmentation pipeline to enhance the generator's diversity and automate multimodal format conversion.

- Text Embedding & Conditioning Augmentation:  
    Raw text descriptions are encoded into fixed-length text embeddings. To prevent mode collapse and smooth the latent conditioning manifold, we apply Conditioning Augmentation (CA), dynamically sampling latent variables from a Gaussian distribution parameterized by the text embeddings.
- Image Preprocessing:  
    Input images are dynamically resized to the target resolutions (e.g., 64x64 for early stages and higher resolutions for later stages). Pixel values are normalized to the `[-1, 1]` range to align with the `tanh` activation function utilized at the output layer of the Generator.
- Online Augmentation:  
    Utilizing the `tf.data` API, we built a robust data loader that serves matched (image, text) pairs and mismatched (wrong image, text) pairs. It dynamically applies random horizontal flips and minor spatial jitters during training to prevent the Discriminator from simply memorizing the training set.

## Model Architectures
To evaluate the impact of different generative frameworks, the project implements the following architectures:

- Baseline DC-GAN:   
    Utilizes standard transposed convolutional layers in the Generator and strided convolutions with LeakyReLU in the Discriminator, directly mapping text embeddings and random noise to a target image resolution in a single pass.
- StackGAN - Stage I:   
    Focuses on drawing the basic shape and primary colors of the object based on the text description, outputting a low-resolution image that captures the global semantic layout.
- StackGAN - Stage II:   
    Takes the Stage-I low-resolution image and the original text embedding as inputs to correct defects and add compelling, photo-realistic details, outputting a high-resolution final image.

## Coding and Required Environment

### Environment  
The project uses Docker (`docker-compose.yml` & `Dockerfile`) to establish an isolated development environment containing TensorFlow and a Jupyter Lab Server.  
Hardware requires a CUDA-enabled GPU to accelerate adversarial training loops and deep learning computations.

### Dependencies
- Deep Learning: `tensorflow`, `keras`
- Data Processing: `pandas`, `numpy`
- Visualization & Environment: `matplotlib`, `jupyterlab`, `Pillow` (PIL), `tqdm`

### Execution
- Environment Setup:  
  Run `docker-compose up -d --build` in the project root to build and launch the container. Access the Jupyter environment via the designated port to open `Reverse Image Caption.ipynb`.
- Preprocessing:  
  Loads the text embeddings and image datasets, setting up the `tf.data.Dataset` pipelines and loss functions (adversarial loss and KL-divergence loss for Conditioning Augmentation).
- Training:  
  Compiles the Generator and Discriminator networks and initiates the alternating min-max training process. The custom training loop meticulously balances the updates between the Discriminator and Generator.
- Generation & Visualization:  
  Loads the trained Generator weights. The model takes novel text descriptions, encodes them, and generates corresponding synthetic images, using `matplotlib` to render the outputs and track visual progression across epochs.

# References
- [StackGAN: Text to Photo-realistic Image Synthesis with Stacked Generative Adversarial Networks](https://arxiv.org/abs/1612.03242)
- [Unsupervised Representation Learning with Deep Convolutional Generative Adversarial Networks (DCGAN)](https://arxiv.org/abs/1511.06434)
- [TensorFlow DCGAN Tutorial](https://www.tensorflow.org/tutorials/generative/dcgan)