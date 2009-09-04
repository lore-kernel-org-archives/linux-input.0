From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: A few changes to pxa27x_keypad
Date: Fri, 4 Sep 2009 15:45:42 +0800
Message-ID: <f17812d70909040045j688f1ae8la7b67e0acc813f9d@mail.gmail.com>
References: <20090721080845.GD10168@dtor-d630.eng.vmware.com>
	<4A659C28.3040305@compulab.co.il> <20090723063044.GD2782@dtor-d630.eng.vmware.com>
	<20090723072802.GB3997@dtor-d630.eng.vmware.com> <20090723073625.GC3997@dtor-d630.eng.vmware.com>
	<20090904055259.5D44C526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:13033 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583AbZIDHqB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Sep 2009 03:46:01 -0400
Received: by qw-out-2122.google.com with SMTP id 8so191579qwh.37
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2009 00:46:02 -0700 (PDT)
In-Reply-To: <20090904055259.5D44C526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-input@vger.kernel.org

On Fri, Sep 4, 2009 at 1:20 PM, Dmitry
Torokhov<dmitry.torokhov@gmail.com> wrote:
> On Thu, Jul 23, 2009 at 12:36:25AM -0700, Dmitry Torokhov wrote:
>> On Thu, Jul 23, 2009 at 12:28:02AM -0700, Dmitry Torokhov wrote:
>> > On Wed, Jul 22, 2009 at 11:30:44PM -0700, Dmitry Torokhov wrote:
>> > > On Tue, Jul 21, 2009 at 01:44:56PM +0300, Mike Rapoport wrote:
>> > > > Hi Dmitry,
>> > > >
>> > > > Dmitry Torokhov wrote:
>> > > > > Hi Eric,
>> > > > >
>> > > > > I made a few adjustments to the pxa27x_keypad driver and was wondering
>> > > > > if you would be able to give it a sping and check if I broke it or not.
>> > > >
>> > > > Apparently not :)
>> > > > Tested-by: Mike Rapoport <mike@compulab.co.il>
>> > > >
>> > >
>> > > Cool, thanks for testing. I have another one for you then ;)
>> > >
>> > > TIA!
>> > >
>> >
>> > Umm.. this one is hopefully better...
>> >
>>
>> And another one implementing keymap manipulation.
>>
>
> *ping* Any chance you could try this one out for me? Pretty please...
>

Hi Dmitry,

Mike has already tested this, and I tested this again on my Littleton/pxa3xx,
it works pretty good, and the change looks quite OK, so if you need my Ack,
here it goes:

Acked-by: Eric Miao <eric.y.miao@gmail.com>
