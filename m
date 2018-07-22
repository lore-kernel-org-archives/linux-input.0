From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 02/11] touchscreen: ad7877: Use octal permissions
Date: Sun, 22 Jul 2018 01:29:07 -0700
Message-ID: <726de8d70365597715ed62c0d99bf2a7adaa3362.camel@perches.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 2018-07-22 at 00:39 +0530, dev-harsh1998 wrote:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
[]
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
[]
> @@ -461,7 +461,7 @@ name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
>  		return v; \
>  	return sprintf(buf, "%u\n", (unsigned) v); \
>  } \
> -static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
> +static DEVICE_ATTR(name, 0444, name ## _show, NULL);

I believe this could be

static DEVICE_ATTR_RO(name)
