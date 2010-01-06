From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Input: Add device_enable handler to DaVinci
	Keyscan platform data
Date: Tue, 05 Jan 2010 16:21:11 -0800
Message-ID: <87aawsozgo.fsf@deeprootsystems.com>
References: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com>
	<87hbs25n38.fsf@deeprootsystems.com>
	<20091208004832.GA9495@core.coreip.homeip.net>
	<877hsy46o0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <877hsy46o0.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> (Kevin Hilman's message of
	"Mon\, 07 Dec 2009 17\:05\:03 -0800")
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> writes:

> Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>
>> On Mon, Dec 07, 2009 at 04:24:59PM -0800, Kevin Hilman wrote:
>>> <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org> writes:
>>> 
>>> > From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
>>> >
>>> > Add a function pointer in the platform data of the DaVinci Keyscan driver
>>> > called device_enabled, in order to perform board specific actions when
>>> > the device is initialized, like setup the PINMUX configuration.
>>> >
>>> > Signed-off-by: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
>>> 
>>> Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>>> 
>>> Dmitry,
>>> 
>>> Will you be queueing this driver (and this patch) for 2.6.34?  I
>>> thought you had accepted the original driver, but I don't see it in
>>> the master or next branch of your input tree at:
>>> 
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>>
>> The driver is there, commit bc09dcadc1a3da87d58aa70ebc8e9441205be75c on
>> 'next' branch (I don't really use master branch).  It was committed back
>> in October, probably that's why you don't see it?
>>
>> As far as the patch goes - I got an impression from email sent by
>> Steve that there are ways to do automatic PINMUX detection and thus
>> this patch was not needed.  Is this ture?
>
> The method Steve was referring to was done for MontaVista
> internal/product kernels but was rejected for upstream (by me) because
> of the way it was implemented (by tying mux settings to clock
> settings.)
>
>> If not I am stull unsure what happens if you unload the driver. How
>> do you restore the old configuration so that the device you took
>> over from can start working again? Maybe pinmux should be controlled
>> via sysfs attribute (in board code) so that user can switch on-fly
>> between the devices?
>
> The way we currently handle MUXing in davinci, you don't need to do
> anything after the driver unloads.  Any other user of these pins will
> mux them as needed.
>
> If really necessary, we could do an equivalent 'device_disable' hook
> but there would be empty as it wouldn't be needed.
>
> So, speaking as maintainer of the DaVinci support, I'm in favor of this
> approach from Miguel.

Dmitry,

Unless there are further objectsions, could you please queue this
patch for 2.6.34 with my signoff?

Thanks,

Kevin
