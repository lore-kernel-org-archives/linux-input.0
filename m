From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCHv4 4/6] input/cma3000_d0x: Add CMA3000 spi support
Date: Tue, 25 Oct 2011 09:24:48 +0200
Message-ID: <CAPybu_3pF6u10JMmcbho1e7=8EPHMq8LQ1+uHpyVMOmbRMUsHA@mail.gmail.com>
References: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com>
 <1319487676-27181-5-git-send-email-ricardo.ribalda@gmail.com> <20111024213635.GB4394@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35442 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922Ab1JYHZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Oct 2011 03:25:28 -0400
In-Reply-To: <20111024213635.GB4394@ponder.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, jic23@cam.ac.uk, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Grant

  Thanks for your comments. I am fixing the  --- problem in all the pat=
ches.

>
> Mark Brown had posted a generic indirect register read/write library
> that I believe is getting merged. =A0Maybe this driver should be usin=
g
> it?

It is not on linux-next, and also it cannot be used directly, in order
to read you have to do set reg=3D (reg << 2) | 2; And AFAIK it is not
supported by the regmap

>
> Drop the .bus line. =A0The core code does this bit for you.

Done

>> +module_init(cma3000_spi_init);
>> +module_exit(cma3000_spi_exit);
>
> move module_init() directly below the function it registers.

Also done, but I believe the other is more elegant :)
>
>> +
>> +MODULE_DESCRIPTION("CMA3000-D0x Accelerometer SPI Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
>> --
>> 1.7.7
>>
>



--=20
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
