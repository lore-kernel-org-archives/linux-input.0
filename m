From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v8 3/4] i2c: i801: add support of Host Notify
Date: Wed, 15 Jun 2016 10:12:47 +0200
Message-ID: <20160615081247.GQ24234@mail.corp.redhat.com>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-4-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465484030-28838-4-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jun 09 2016 or thereabouts, Benjamin Tissoires wrote:
> The i801 chip can handle the Host Notify feature since ICH 3 as mentioned
> in http://www.intel.com/content/dam/doc/datasheet/82801ca-io-controller-hub-3-datasheet.pdf
> 
> Enable the functionality unconditionally and propagate the alert
> on each notification.
> 
> With a T440s and a Synaptics touchpad that implements Host Notify, the
> payload data is always 0x0000, so I am not sure if the device actually
> sends the payload or if there is a problem regarding the implementation.
> 
> Tested-by: Andrew Duggan <aduggan@synaptics.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> changes in v2:
> - removed the description of the Slave functionality support in the chip table
>   (the table shows what is supported, not what the hardware is capable of)
> - use i2c-smbus to forward the notification
> - remove the fifo, and directly retrieve the address and payload in the worker
> - do not check for Host Notification is the feature is not enabled
> - use inw_p() to read the payload instead of 2 inb_p() calls
> - add /* fall-through */ comment
> - unconditionally enable Host Notify if the hardware supports it (can be
>   disabled by the user)
>  
> no changes in v3
> 
> changes in v4:
> - make use of the new API -> no more worker spawning here
> - solved a race between the access of the Host Notify registers and the actual
>   I2C transfers.
> 
> changes in v5:
> - added SKL Host Notify support
> 
> changes in v6:
> - select I2C_SMBUS in Kconfig to prevent an undefined reference when I2C_I801
>   is set to 'Y' while I2C_SMBUS is set to 'M'
> 
> no changes in v7
> 
> changes in v8:
> - reapplied after http://patchwork.ozlabs.org/patch/632768/ and merged the
>   conflict (minor conflict in the struct i801_priv).
> - removed the .resume hook as upstream changed suspend/resume hooks and there
>   is no need in the end to re-enable host notify on resume (tested on Lenovo
>   t440 and t450).

Actually, this hook seemed to be required on the Lenovo T440 (Haswell)
but not on the T450 (Broadwell) laptop I have now here.

Wolfram, I can resend the whole series or a follow-up patch to re-enable
after resume Host Notify. How do you prefer I deal with that?

Cheers,
Benjamin
