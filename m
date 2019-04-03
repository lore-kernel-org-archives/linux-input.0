From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev - use struct_size() in kzalloc() and
 vzalloc()
Date: Wed, 3 Apr 2019 10:51:22 -0700
Message-ID: <20190403175122.GA53104@dtor-ws>
References: <20190221153738.GA17825@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190221153738.GA17825@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Feb 21, 2019 at 09:37:38AM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> instance = kzalloc(size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> Notice that, in this case, variable size is not necessary, hence
> it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/evdev.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index f48369d6f3a0..ee8dd8b1b09e 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -503,14 +503,13 @@ static int evdev_open(struct inode *inode, struct file *file)
>  {
>  	struct evdev *evdev = container_of(inode->i_cdev, struct evdev, cdev);
>  	unsigned int bufsize = evdev_compute_buffer_size(evdev->handle.dev);
> -	unsigned int size = sizeof(struct evdev_client) +
> -					bufsize * sizeof(struct input_event);
>  	struct evdev_client *client;
>  	int error;
>  
> -	client = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
> +	client = kzalloc(struct_size(client, buffer, bufsize),
> +			 GFP_KERNEL | __GFP_NOWARN);
>  	if (!client)
> -		client = vzalloc(size);
> +		client = vzalloc(struct_size(client, buffer, bufsize));
>  	if (!client)
>  		return -ENOMEM;
>  
> -- 
> 2.20.1
> 

-- 
Dmitry
