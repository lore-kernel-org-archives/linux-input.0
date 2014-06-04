From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCHv2 3/3] IIO: hid-sensor-magn-3d: Add in support for True/Magnetic
 North HID usages
Date: Wed, 04 Jun 2014 08:42:34 -0700
Message-ID: <538F3E6A.4080905@linux.intel.com>
References: <1401750890-31854-1-git-send-email-reyad.attiyat@gmail.com> <1401750890-31854-4-git-send-email-reyad.attiyat@gmail.com> <538E092F.9040004@linux.intel.com> <CA+BWVUTxnS_C+EXm1SuShywk998+E5KfTdtTrS6_a0+k+4U4ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17807 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbaFDPi0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Jun 2014 11:38:26 -0400
In-Reply-To: <CA+BWVUTxnS_C+EXm1SuShywk998+E5KfTdtTrS6_a0+k+4U4ig@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On 06/04/2014 08:23 AM, Reyad Attiyat wrote:
> Hey Srinivas,
>
> On Tue, Jun 3, 2014 at 12:43 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>
>>
>> May be we should have a field in const struct iio_chan_spec, so that we
>> can dynamically enable disable channels. In this way we can statically
>> define channels, but can be enabled/disabled dynamically.
>>
> Would this require changing iio subsystem to create sysfs entries only
> when enabled? Would we need to add functions to disable and enable
> later on?

This is just a thought. You don't have to change it. I am sure Jonathan 
will have some opinion this.

>>
>> I think we need to present angle in radians. Are you basing change present
>> in linux-next? This will automatically do in this function.
>>
> I'll look into this. What function should I use to make the iio chanel
> to report radians?
I think it will work if the existing sequence is maintained
  st->scale_precision = hid_sensor_format_scale(
                                 HID_USAGE_SENSOR_COMPASS_3D,
                                 &st->magn[CHANNEL_SCAN_INDEX_X],
                                 &st->scale_pre_decml, 
&st->scale_post_decml);

So as long as you call this function, the scale value to user space will
be returned correctly.

>>
>>
>> I don't see kfree. Try devm_kcalloc?
>>
> I changed kmemdup to kcalloc so there is still a kfree in the exsiting
> code. I can change this to devm_kcalloc but only if we don't go with
> static channels that are enabled as found.
>
Since you are changing this part, devm_ calls are preferred, I think.

Thanks,
Srinivas


> Thanks,
> Reyad Attiyat
>

