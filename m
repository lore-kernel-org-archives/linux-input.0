From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCHv3 6/7] input/cma3000_d0x: Unwind reverse order of init
Date: Tue, 18 Oct 2011 18:57:24 +0200
Message-ID: <CAPybu_16xkTK1dn_NKzduxb6Q=fESyi6d0mDswkDqUMOtoPfcg@mail.gmail.com>
References: <1318952886-835-1-git-send-email-ricardo.ribalda@gmail.com>
 <1318952886-835-7-git-send-email-ricardo.ribalda@gmail.com> <201110180953.34156.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47544 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095Ab1JRQ6E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 12:58:04 -0400
In-Reply-To: <201110180953.34156.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, jic23@cam.ac.uk, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Dmitry

 You are right, and also could be a good idea to init the irq, only
after the input device has been registered. Dont you think so?

  Thanks

On Tue, Oct 18, 2011 at 18:53, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tuesday, October 18, 2011 08:48:05 AM Ricardo Ribalda Delgado wrot=
e:
>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>> ---
>> =A0drivers/input/misc/cma3000_d0x.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/misc/cma3000_d0x.c
>> b/drivers/input/misc/cma3000_d0x.c index bbda34c..96a46d4 100644
>> --- a/drivers/input/misc/cma3000_d0x.c
>> +++ b/drivers/input/misc/cma3000_d0x.c
>> @@ -459,8 +459,8 @@ EXPORT_SYMBOL(cma3000_init);
>>
>> =A0void cma3000_exit(struct cma3000_accl_data *data)
>> =A0{
>> - =A0 =A0 free_irq(data->irq, data);
>> =A0 =A0 =A0 input_unregister_device(data->input_dev);
>> + =A0 =A0 free_irq(data->irq, data);
>> =A0 =A0 =A0 kfree(data);
>> =A0}
>> =A0EXPORT_SYMBOL(cma3000_exit);
>
> No, the original is much safer. Unless you 110% sure you won't get
> an interrupt between unregistering device (which is most likely
> will free the associated data structure) and freeing irq it is
> better to leave it as is.
>
> Thanks.
>
> --
> Dmitry
>



--=20
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
