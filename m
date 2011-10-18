From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 5/5] Input: add CMR3000 gyrsocope driver
Date: Tue, 18 Oct 2011 14:07:32 +0200
Message-ID: <CAPybu_1nfTQd1ZbKJOwoxyZuPvKkCh8z2tdrcpwuzQSz5CM4Rg@mail.gmail.com>
References: <1318926486-10330-1-git-send-email-ricardo.ribalda@gmail.com>
 <1318926486-10330-6-git-send-email-ricardo.ribalda@gmail.com> <4E9D3EAE.9020003@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35420 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291Ab1JRMIM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 08:08:12 -0400
In-Reply-To: <4E9D3EAE.9020003@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Jonathan

On Tue, Oct 18, 2011 at 10:54, Jonathan Cameron <jic23@cam.ac.uk> wrote=
:
> On 10/18/11 09:28, Ricardo Ribalda Delgado wrote:

> Quick review done below. =A0Quite a bit of overlap with earlier revie=
ws.
> Sorry I couldn't take a closer look.

I am fixing also previous errors

> accl? =A0I thought this was a gyro so this seems odd.
copy paste :), fixing it

> I'd much rather see these done explicity in the code.
> This sort of macro just obscures the works to save a few lines
> of code.
>> +#define CMR3000_READ(data, reg, msg) \
>> + =A0 =A0 (data->bus_ops->read(data->dev, reg, msg))
>> +#define CMR3000_SET(data, reg, val, msg) \
>> + =A0 =A0 ((data)->bus_ops->write(data->dev, reg, val, msg))
>> +

=46ixing it


>> +void cmr3000_exit(struct cmr3000_accl_data *data)
>> +{
>> + =A0 =A0 free_irq(data->irq, data);
>> + =A0 =A0 input_unregister_device(data->input_dev);
> cleaner to unwind in reverse order of setup unless you have
> a good reason and that should be commented.

=46ixing it, and also fixing it on the cma3000

> Match comment to name fo structure.
>> + * struct cmr3000_i2c_platform_data - CMR3000 Platform data
>> + * @fuzz_x: Noise on X Axis
>> + * @fuzz_y: Noise on Y Axis
>> + * @fuzz_z: Noise on Z Axis
>> + * @mode: Operating mode
>> + * @irq_level: Irq level
>> + */
>> +struct cmr3000_platform_data {
>> + =A0 =A0 int fuzz_x;
>> + =A0 =A0 int fuzz_y;
>> + =A0 =A0 int fuzz_z;
>> + =A0 =A0 uint8_t irq_level;
>> + =A0 =A0 uint8_t mode;
>> + =A0 =A0 unsigned long irqflags;
>> +};

=46ixing it, and also fixing it on the cma3000


Thanks!



--=20
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
