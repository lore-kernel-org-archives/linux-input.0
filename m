From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fwd: Re: [PATCH v2] input: misc: Add driver for Intel Bay
 Trail GPIO buttons
Date: Wed, 16 Apr 2014 00:20:01 +0200
Message-ID: <20140415222001.GA2431@amd.pavel.ucw.cz>
References: <5338D095.6020200@linux.intel.com>
 <5338D410.9060406@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5338D410.9060406@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zhu, Lejun" <lejun.zhu@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, yu-sheng Chen <verylong2@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi!
> 
> Input: misc - Add driver for Intel Bay Trail GPIO buttons
> 
> From: Lejun Zhu <lejun.zhu@linux.intel.com>
> 
> This patch adds support for the GPIO buttons on some Intel Bay Trail
> tablets originally running Windows 8. The ACPI description of these
> buttons follows "Windows ACPI Design Guide for SoC Platforms".

Hmm. Is it time for x86 to adopt device tree? Because this is 200
lines of C code which should really have been 10 lines of .dts...

> +
> +/*
> + * Some of the buttons like volume up/down are auto repeat, while others
> + * are not. To support both, we register two platform devices, and put
> + * buttons into them based on whether the key should be auto repeat.
> + */
> +#define BUTTON_TYPES	2
> +
> +struct soc_button_data {
> +	struct platform_device *children[BUTTON_TYPES];
> +};

Would it be possible to extend device description so that this hack is
not needed?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
