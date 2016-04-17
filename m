From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iio: mxs-lradc: Move binding document out of staging as
 well
Date: Sun, 17 Apr 2016 09:59:02 +0100
Message-ID: <57135056.1000402@kernel.org>
References: <1460293398-23654-1-git-send-email-harald@ccbib.org>
 <20160411194204.GA17762@rob-hp-laptop> <570EC62C.7010306@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570EC62C.7010306-ynQEQJNshbs@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 13/04/16 23:20, Marek Vasut wrote:
> On 04/11/2016 09:42 PM, Rob Herring wrote:
>> On Sun, Apr 10, 2016 at 01:03:18PM +0000, Harald Geyer wrote:
>>> commit f836c45922446df872250a12dd08e48978aceb2f moved mxs-lradc driver
>>> out of staging. However the binding document was left in the old place.
>>
>> A move out of staging should probably imply a review. Though we don't 
>> have clear rules around that for bindings.
>>
>>>
>>> Signed-off-by: Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>
cc'ing Dmitry and linux-input.
>>> ---
>>>  .../devicetree/bindings/iio/adc/mxs-lradc.txt      | 47 ++++++++++++++++++++++
>>>  .../bindings/staging/iio/adc/mxs-lradc.txt         | 47 ----------------------
>>>  2 files changed, 47 insertions(+), 47 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
>>>  delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
>>> new file mode 100644
>>> index 0000000..555fb11
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
>>> @@ -0,0 +1,47 @@
>>> +* Freescale MXS LRADC device driver
>>> +
>>> +Required properties:
>>> +- compatible: Should be "fsl,imx23-lradc" for i.MX23 SoC and "fsl,imx28-lradc"
>>> +              for i.MX28 SoC
>>> +- reg: Address and length of the register set for the device
>>> +- interrupts: Should contain the LRADC interrupts
>>> +
>>> +Optional properties:
>>> +- fsl,lradc-touchscreen-wires: Number of wires used to connect the touchscreen
>>> +                               to LRADC. Valid value is either 4 or 5. If this
>>> +                               property is not present, then the touchscreen is
>>> +                               disabled. 5 wires is valid for i.MX28 SoC only.
>>
>> Standard touchscreen property?
> 
> Looks quite standard-ish to me indeed. It is my fault for bringing this
> baggage in back when I wrote the driver, but now that we're moving the
> driver out of staging, it would make sense to deprecate such properties
> and use standard ones (if they got fleshed out during that time).
> 
> We now have "atmel,adc-ts-wires" , "ti,wires" ,
> "fsl,lradc-touchscreen-wires" , so some sort of pattern is developing here.
> 
>>> +- fsl,ave-ctrl: number of samples per direction to calculate an average value.
>>> +                Allowed value is 1 ... 32, default is 4
>>> +- fsl,ave-delay: delay between consecutive samples. Allowed value is
>>> +                 2 ... 2048. It is used if 'fsl,ave-ctrl' > 1, counts at
>>> +                 2 kHz and its default is 2 (= 1 ms)
>>
>> ditto.
>>
>> If not, it should have units.
> 
> Agreed, this is standard ADC sampling frequency I think.
> 
>>> +- fsl,settling: delay between plate switch to next sample. Allowed value is
>>> +                1 ... 2047. It counts at 2 kHz and its default is
>>> +                10 (= 5 ms)
>>
>> ditto.
>>
>>> +
>>> +Example for i.MX23 SoC:
>>> +
>>> +	lradc@80050000 {
>>> +		compatible = "fsl,imx23-lradc";
>>> +		reg = <0x80050000 0x2000>;
>>> +		interrupts = <36 37 38 39 40 41 42 43 44>;
>>> +		status = "okay";
>>> +		fsl,lradc-touchscreen-wires = <4>;
>>> +		fsl,ave-ctrl = <4>;
>>> +		fsl,ave-delay = <2>;
>>> +		fsl,settling = <10>;
>>> +	};
>>> +
>>> +Example for i.MX28 SoC:
>>> +
>>> +	lradc@80050000 {
>>> +		compatible = "fsl,imx28-lradc";
>>> +		reg = <0x80050000 0x2000>;
>>> +		interrupts = <10 14 15 16 17 18 19 20 21 22 23 24 25>;
>>> +		status = "okay";
>>> +		fsl,lradc-touchscreen-wires = <5>;
>>> +		fsl,ave-ctrl = <4>;
>>> +		fsl,ave-delay = <2>;
>>> +		fsl,settling = <10>;
>>> +	};
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
