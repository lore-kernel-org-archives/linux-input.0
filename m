From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 5/17] input: rmidev character driver for RMI4 sensors
Date: Mon, 27 Aug 2012 11:49:21 -0700
Message-ID: <CACRpkdYGR=YtgyvDjfH4w8OMnn3iZKuRpQKrTVCE=i=gZ1hPuw@mail.gmail.com>
References: <1345241877-16200-1-git-send-email-cheiny@synaptics.com>
	<1345241877-16200-6-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345241877-16200-6-git-send-email-cheiny@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Peichen Chang <peichen.chang@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 17, 2012 at 3:17 PM, Christopher Heiny <cheiny@synaptics.com> wrote:

> Driver for Synaptics touchscreens using RMI4 protocol.

Really? This looks more like some custom char driver to get a pipe
into the device from userspace. Put in a proper description of what this
is for.

If the purpose is to read/write arbitrary addresses in the device,
you should use regmap's debugfs interface for this instead,
it is much better suited for the task.

(...)
> +#define RMI_CHAR_DEV_TMPBUF_SZ 128
> +#define RMI_REG_ADDR_PAGE_SELECT 0xFF
> +#define REG_ADDR_LIMIT 0xFFFF
> +
> +struct rmidev_data {
> +       /* mutex for file operation*/
> +       struct mutex file_mutex;
> +       /* main char dev structure */
> +       struct cdev main_dev;
> +
> +       /* pointer to the corresponding RMI4 device.  We use this to do */
> +       /* read, write, etc. */
> +       struct rmi_device *rmi_dev;
> +       /* reference count */
> +       int ref_count;

Something tells me you should atleast use <linux/kref.h> for this.
It also solves a few atomicity problems in a good standard way.
See Documentation/kref.txt

> +/*store dynamically allocated major number of char device*/
> +static int rmidev_major_num;

You need to patch your desired major number into
Documentation/devices.txt

> +static struct class *rmidev_device_class;

Last time discussed with Greg, class devices were deprecated,
and you should just use a bus instead. (But not sure.)

Yours,
Linus Walleij
