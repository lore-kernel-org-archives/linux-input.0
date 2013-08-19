From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] include: dt-binding: input: create a DT header defining
 key codes.
Date: Mon, 19 Aug 2013 10:24:56 -0600
Message-ID: <521246D8.9040506@wwwdotorg.org>
References: <1375798370-2231-1-git-send-email-ldewangan@nvidia.com> <52014E50.6030508@wwwdotorg.org> <5203D138.4030107@nvidia.com> <20130808171331.GA6960@core.coreip.homeip.net> <5203D487.5020507@wwwdotorg.org> <20130812171504.GA31418@core.coreip.homeip.net> <52092299.4080104@wwwdotorg.org> <52123152.9070408@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52123152.9070408-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 08/19/2013 08:53 AM, Laxman Dewangan wrote:
> On Monday 12 August 2013 11:29 PM, Stephen Warren wrote:
>> On 08/12/2013 11:15 AM, Dmitry Torokhov wrote:
>>>>
>>>> Device tree files can only include headers in include/dt-bindings.
>>>> Eventually/soon, all the DT files and the headers in the dt-bindings/
>>>> directory will be split out into a separate git tree, which does not
>>>> have access to include/uapi, or indeed any other Linux kernel header
>>>> files.
>>> OK, that makes it easier for me - please merge through whatever tree
>>> that owns include/dt-bindings.
>> Are there any objections to my taking both patches through the Tegra
>> tree? Patch 2/2 depends on 1/2 and is Tegra-specific. This should work
>> out fine unless anyone else wants to use the new header this kernel
>> cycle; if they do, this should go into a topic branch in the DT tree
>> that I can pull into the Tegra tree.
> 
> Hi Stephen,
> Just wanted to check if you are taking this on Tegra tree. I want to
> post some more cleanups on other dts file  to use dt-binding include for
> key code otherwise I will defer for next kernel version.

At this time, I assume this will go through the DT repo/branch. Rob?
