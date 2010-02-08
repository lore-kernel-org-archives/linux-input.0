From: Jebediah Huang <jebediah.huang@gmail.com>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Mon, 8 Feb 2010 15:56:10 +0800
Message-ID: <bf0eec9a1002072356x443c729fpa1c4a8c72209dfec@mail.gmail.com>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
	 <f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
	 <bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
	 <20100208073612.GV28972@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14194 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab0BHH4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 02:56:12 -0500
Received: by fg-out-1718.google.com with SMTP id 19so13766fgg.1
        for <linux-input@vger.kernel.org>; Sun, 07 Feb 2010 23:56:11 -0800 (PST)
In-Reply-To: <20100208073612.GV28972@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Feb 8, 2010 at 3:36 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Mon, Feb 08, 2010 at 03:02:14PM +0800, Jebediah Huang wrote:
>>
>> output if max732x enabled is:
>> # ./i2ctest
>> [ =A0184.070025] i2c: error: exhausted retries
>> fd=3D3
>> t=3D-1
>> [ =A0184.074256] i2c: msg_num: 0 msg_idx: -2000 msg_ptr: 0
>> [ =A0184.080428] i2c: ICR: 000007e0 ISR: 00000002
>> [ =A0184.080444] i2c: log: [00000006:00000000] [00000006:00000000]
>> [00000006:00000000] [00000006:00000000] [00000006:00000000]
>> [00000006:00000000] [00000006:00
>> 000000] [00000006:00000000] [00000006:00000000] [00000006:00000000]
>> [00000006:00000000] [00000007:00000000] [00000447:000007e0]
>> t=3D-1
>
> How do you enable/disable the chip? As Eric said, the error above
> indicates an eletrical issue with the bus.

I disable by doing menuconfig and disable max732x:

# CONFIG_GPIO_MAX732X is not set

>
>> disable max732x is:
>> # ./i2ctest no button pressed
>
> What are you testing without the chip?
>

I am testing the I2C from i2ctest application using I2C_PXA.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
