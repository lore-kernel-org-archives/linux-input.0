From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Tue, 5 Feb 2019 05:15:57 -0800
Message-ID: <20190205131557.GB4225@innovation.ch>
References: <20190204081947.25152-3-ronald@innovation.ch>
 <20190205102110.GG2581@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205102110.GG2581@kadam>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kbuild@01.org, kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


  Hi Dan,

On Tue, Feb 05, 2019 at 01:21:10PM +0300, Dan Carpenter wrote:
> Hi Ronald,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Ronald-Tschal-r/drm-bridge-sil_sii8620-depend-on-INPUT-instead-of-selecting-it/20190205-003319
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> 
> smatch warnings:
> drivers/input/keyboard/applespi.c:1551 applespi_get_saved_bl_level() warn: returning -1 instead of -ENOMEM is sloppy
[snip]
> cfa9f3705 Ronald Tschalär 2019-02-04  1549  	efivar_entry = kmalloc(sizeof(*efivar_entry), GFP_KERNEL);
> cfa9f3705 Ronald Tschalär 2019-02-04  1550  	if (!efivar_entry)
> cfa9f3705 Ronald Tschalär 2019-02-04 @1551  		return -1;

Agreed, that is sloppy. Fixed in for next version. Thanks!


  Cheers,

  Ronald
