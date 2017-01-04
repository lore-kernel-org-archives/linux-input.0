From: "Song, Hongyan" <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2] iio: Add support for linear accel
Date: Wed, 4 Jan 2017 02:28:23 +0000
Message-ID: <AE3E3DFA698D6144A7445C92D1D41E2F10BDBE64@SHSMSX103.ccr.corp.intel.com>
References: <1483456430-6980-1-git-send-email-hongyan.song@intel.com>
 <alpine.DEB.2.02.1701030821450.18919@pmeerw.net>
 <AE3E3DFA698D6144A7445C92D1D41E2F10BDBD57@SHSMSX103.ccr.corp.intel.com>
 <alpine.DEB.2.02.1701030851430.18919@pmeerw.net>
 <be267c7a-9ec3-d86e-2a32-2faef3e0650f@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <be267c7a-9ec3-d86e-2a32-2faef3e0650f-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Lars & Peter,

-----Original Message-----
From: Lars-Peter Clausen [mailto:lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org] 
Sent: Tuesday, January 3, 2017 5:49 PM
To: Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>; Song, Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Pandruvada, Srinivas <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] iio: Add support for linear accel

On 01/03/2017 09:04 AM, Peter Meerwald-Stadler wrote:
> Hi,
> 
>> 	 I checked and find that iio device name is usually named to be with underline if it has more than one word, so I assigned to be " linear_accel_3d".
>>  I think the device property node named to be "in_linear_accel_x_raw" is better than " in_linearaccel_x_raw" Just follow the former coding style.
>> "linearaccel" is only a name which specify IIO type 
>> [IIO_LINEAR_ACCEL] I name [IIO_LINEAR_ACCEL] to be "linearaccel" just follow the history code style in " iio_chan_type_name_spec[]" which do not have any underline.
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
> >linearaccel vs. linear_accel is a matter of taste, I have no 
> >preference; nevertheless, the documentation should match what IIO 
>> outputs

>We use underscores as the field separator in the channel name. Having a underscore as part of a field adds ambiguity and makes it a lot  >
>harder to machine parse it. It's already complicated enough as it is. We should avoid adding types with underscores in them.

Thanks for your advice, I will update the patch.

BR
Song Hongyan
