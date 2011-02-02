From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: Re: [PATCH v2] altera_ps2: Add devicetree support
Date: Thu, 03 Feb 2011 07:32:43 +0800
Message-ID: <4D49E99B.8080400@wytron.com.tw>
References: <20110117220415.GB17963@angua.secretlab.ca>
	<1295848693-28472-1-git-send-email-thomas@wytron.com.tw>
	<20110202043121.GF29148@angua.secretlab.ca>
	<4D4944AA.5040900@wytron.com.tw>
	<20110202153803.GC20275@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110202153803.GC20275-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 02/02/2011 11:38 PM, Grant Likely wrote:
> On Wed, Feb 02, 2011 at 07:48:58PM +0800, Thomas Chou wrote:
>> On 02/02/2011 12:31 PM, Grant Likely wrote:
>>>> +static const struct of_device_id altera_ps2_match[] = {
>>>> +	{ .compatible = "altr,ps2-1.0", },
>>>
>>> I thought I had seen 'altera' instead of an abbreviation being used in
>>> a previous patch.  I don't care much whether 'altr' or 'altera' is
>>> used, but I'd like to know that there is consensus from the Altera
>>> users so that all the drivers use the same prefix.
>>>
>>
>> We had discussed on nios2-dev mailing list, and decided to use
>> 'altr' as Walter suggested that it saves space.
>>
>> About the documentation on dts binding, shall we have a single
>> altera.txt to describe all Altera related binding, and opencores.txt
>> to describe all OpenCores binding? Or separate file for each core in
>> its driver class?
>
> Since I'm reorganizing the binding documentation to reflect subsystems
> (bindings/spi, bindings/i2c, bindings/powerpc, etc) I'd prefer to see
> a separate file for each type of core.

OK. We will use separate files. I will send an updated patch to include 
the dts binding.

As for nios2 cpu related binding, we shall use binding/nios2 dir. Right?

- Thomas

>
> Eventually, I'd like to define a record format for documenting
> bindings that can generate searchable and crosslinked output, but I've
> not spent any time looking at that seriously yet.
>
> g.
>
>>
>> - Thomas
>
