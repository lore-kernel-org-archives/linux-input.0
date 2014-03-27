From: "Zhu, Lejun" <lejun.zhu@linux.intel.com>
Subject: Re: [PATCH] input: misc: Add driver for Intel Bay Trail GPIO buttons
Date: Thu, 27 Mar 2014 09:09:00 +0800
Message-ID: <53337A2C.9020805@linux.intel.com>
References: <533259F7.3050908@linux.intel.com> <53325F30.4030006@linux.intel.com> <20140326170404.47a6380a@alan.etchedpixels.co.uk> <20140326202029.GB11013@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140326202029.GB11013@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 3/27/2014 4:20 AM, Dmitry Torokhov wrote:
> On Wed, Mar 26, 2014 at 05:04:04PM +0000, One Thousand Gnomes wrote:
>> On Wed, 26 Mar 2014 13:01:36 +0800
>> "Zhu, Lejun" <lejun.zhu@linux.intel.com> wrote:
>>
>>> This patch adds support for the GPIO buttons on some Intel Bay Trail
>>> tablets originally running Windows 8. The ACPI description of these
>>> buttons follows "Windows ACPI Design Guide for SoC Platforms".
>>
>> I'm not sure calling it "Baytrail" is right here - it's in theory a
>> generic interface so probably should be named accordingly
>>
>> Otherwise looks good to me.
> 
> It uses static devices in non-board code - if I unbind and rebind PNP
> device that produces gpio-keys platform devices driver core will not be
> happy.
> 
> Thanks.
> 

Alan, I will think of a better name for it. This is supposed to work for
other "win8 ready" tablets as well, just all I have today are Baytrail
tablets.

Dmitry, thank you for pointing out the bug. I'll fix it and submit again.

Thanks.
Lejun
