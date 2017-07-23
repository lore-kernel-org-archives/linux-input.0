From: Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: [PATCH v3 2/4] i2c: add docs to clarify DMA handling
Date: Sun, 23 Jul 2017 12:26:42 +0100
Message-ID: <20170723122642.0e8ceb37@jic23.retrosnub.co.uk>
References: <20170718102339.28726-1-wsa+renesas@sang-engineering.com>
        <20170718102339.28726-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170718102339.28726-3-wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 18 Jul 2017 12:23:37 +0200
Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org> wrote:

> Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Is this material not perhaps better placed in the sphinx docs?
Up to you of course as your subsystem ;)

Text is good though.

Acked-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
> Changes since v2:
> 
> * documentation updates. Hopefully better wording now
> 
>  Documentation/i2c/DMA-considerations | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/i2c/DMA-considerations
> 
> diff --git a/Documentation/i2c/DMA-considerations b/Documentation/i2c/DMA-considerations
> new file mode 100644
> index 00000000000000..e46c24d65c8556
> --- /dev/null
> +++ b/Documentation/i2c/DMA-considerations
> @@ -0,0 +1,38 @@
> +Linux I2C and DMA
> +-----------------
> +
> +Given that I2C is a low-speed bus where largely small messages are transferred,
> +it is not considered a prime user of DMA access. At this time of writing, only
> +10% of I2C bus master drivers have DMA support implemented. And the vast
> +majority of transactions are so small that setting up DMA for it will likely
> +add more overhead than a plain PIO transfer.
> +
> +Therefore, it is *not* mandatory that the buffer of an I2C message is DMA safe.
> +It does not seem reasonable to apply additional burdens when the feature is so
> +rarely used. However, it is recommended to use a DMA-safe buffer if your
> +message size is likely applicable for DMA. Most drivers have this threshold
> +around 8 bytes. As of today, this is mostly an educated guess, however.
> +
> +To support this scenario, drivers wishing to implement DMA can use helper
> +functions from the I2C core. One checks if a message is DMA capable in terms of
> +size and memory type. It can optionally also create a bounce buffer:
> +
> +	i2c_check_msg_for_dma(msg, threshold, &bounce_buf);
> +
> +The bounce buffer handling from the core is generic and simple. It will always
> +allocate a new bounce buffer. If you want a more sophisticated handling (e.g.
> +reusing pre-allocated buffers), you can leave the pointer to the bounce buffer
> +empty and implement your own handling based on the return value of the above
> +function.
> +
> +The other helper function releases the bounce buffer. It ensures data is copied
> +back to the message:
> +
> +	i2c_release_dma_bounce_buf(msg, bounce_buf);
> +
> +Please check the in-kernel documentation for details. The i2c-sh_mobile driver
> +can be used as a reference example.
> +
> +If you plan to use DMA with I2C (or with any other bus, actually) make sure you
> +have CONFIG_DMA_API_DEBUG enabled during development. It can help you find
> +various issues which can be complex to debug otherwise.
