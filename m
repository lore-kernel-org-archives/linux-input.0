From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCHv4 1/6] input/cma3000_d0x: Support devices without pdata
Date: Wed, 2 Nov 2011 15:51:42 +0100
Message-ID: <CAPybu_30aorqCzvXhUWHZeBc7D1mfqzAR0c13R5rKL3GL1-WVA@mail.gmail.com>
References: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com>
 <1319487676-27181-2-git-send-email-ricardo.ribalda@gmail.com>
 <20111024213104.GA4394@ponder.secretlab.ca> <CAPybu_3EPJYd1EdzgF1oF6_k8u5nr4Kx1zmdPRXNZ_zcACrUEw@mail.gmail.com>
 <CACxGe6uAMugBRAqeN5D-HfX4G+DysLFjfp7=ZeC378cAdwOAwA@mail.gmail.com> <CAPybu_0eY2HGQNgXOeH13v5Ba47JiO-oY2mSxnfyLQTegQDzNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33607 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664Ab1KBOwX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 10:52:23 -0400
In-Reply-To: <CAPybu_0eY2HGQNgXOeH13v5Ba47JiO-oY2mSxnfyLQTegQDzNQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, jic23@cam.ac.uk, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Ok, found it, and implement it.... Please check the new patchset :)

Thanks

On Wed, Nov 2, 2011 at 13:41, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Hello Grant
> =A0Thanks for your feedback
>
>>>> No of_device_id match table to match against compatible values?
>>>
>>> I think it is not needed, the device will be matched against the
>>> driver cma3000_d0x_spi.c and AFAIK on the spi/i2c devices you dont
>>> need the device_id match. But you know much more about this :). =A0=
Can
>>> you point me to a example where a spi driver uses of_device-id matc=
h.
>>
>> Use an of_device_id table. =A0It's the right thing to do.
>>
> Can you point me to a file where of_device_id is used in a spi/i2c
> driver? I thought that was only for mmaped drivers....
>
>
> Thanks!
>
>
> --
> Ricardo Ribalda
>



--=20
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
