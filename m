From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] iio: Add support for linear accel
Date: Tue, 3 Jan 2017 10:49:16 +0100
Message-ID: <be267c7a-9ec3-d86e-2a32-2faef3e0650f@metafoo.de>
References: <1483456430-6980-1-git-send-email-hongyan.song@intel.com>
 <alpine.DEB.2.02.1701030821450.18919@pmeerw.net>
 <AE3E3DFA698D6144A7445C92D1D41E2F10BDBD57@SHSMSX103.ccr.corp.intel.com>
 <alpine.DEB.2.02.1701030851430.18919@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:49132 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdACJua (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2017 04:50:30 -0500
In-Reply-To: <alpine.DEB.2.02.1701030851430.18919@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "Song, Hongyan" <hongyan.song@intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>

On 01/03/2017 09:04 AM, Peter Meerwald-Stadler wrote:
> Hi,
> 
>> 	 I checked and find that iio device name is usually named to be with underline if it has more than one word, so I assigned to be " linear_accel_3d".
>>  I think the device property node named to be "in_linear_accel_x_raw" is better than " in_linearaccel_x_raw" Just follow the former coding style.
>> "linearaccel" is only a name which specify IIO type [IIO_LINEAR_ACCEL]
>> I name [IIO_LINEAR_ACCEL] to be "linearaccel" just follow the history code style in " iio_chan_type_name_spec[]" which do not have any underline.
> 
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_x_raw
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_y_raw
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_z_raw
>>
>> I think this would be in_linearaccel_x_raw, etc.?
> 
>>> @@ -82,6 +82,7 @@ struct bus_type iio_bus_type = {
>>>  	[IIO_UVINDEX] = "uvindex",
>>>  	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
>>>  	[IIO_GRAVITY]  = "gravity",
>>> +	[IIO_LINEAR_ACCEL] = "linearaccel",
>>>  };
> 
> 
> linearaccel vs. linear_accel is a matter of taste, I have no preference;
> nevertheless, the documentation should match what IIO outputs

We use underscores as the field separator in the channel name. Having a
underscore as part of a field adds ambiguity and makes it a lot harder
to machine parse it. It's already complicated enough as it is. We should
avoid adding types with underscores in them.

