From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH v3] input: touchscreen: Remove duplicate ft6236 driver
Date: Fri, 5 Aug 2016 17:07:20 +0200
Message-ID: <72101a2a-ccf0-b0bc-3859-50a43f990027@i2se.com>
References: <1470381871-4086-1-git-send-email-hdegoede@redhat.com>
 <1470381871-4086-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470381871-4086-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Hans,

Am 05.08.2016 um 09:24 schrieb Hans de Goede:
> The new(ish) ft6236 simply re-implements the M09 protocol of the
> (much) older edt-ft5x06.c driver.
>
> This commit removes this duplicate driver and adds the i2c ids and
> dt compatible string to the edt-ft5x06.c driver to keep compatibility.

i think only remove of the driver is incorrect here.

Since there are two similar but still different DT bindings

Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt

Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt

the DT handling of edt-ft5x06.c needs to be extended and then finally 
driver and binding could be removed.

Regards
Stefan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
