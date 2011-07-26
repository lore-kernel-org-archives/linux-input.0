From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 8/9 v2] Input: add BTN_TOOL_QUINTTAP for reporting 5 fingers
 on touchpad
Date: Tue, 26 Jul 2011 16:03:35 -0700
Message-ID: <4E2F47C7.4060702@canonical.com>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org> <1311169146-20066-9-git-send-email-djkurtz@chromium.org> <20110725082918.GC22937@core.coreip.homeip.net> <CAGS+omAQmb-q6xC-Gh6z69iNNyr=rN-Khsq90aCHJwe-6F9ANw@mail.gmail.com> <20110725181645.GA6876@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:43906 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab1GZXDo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 19:03:44 -0400
In-Reply-To: <20110725181645.GA6876@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On 07/25/2011 11:16 AM, Dmitry Torokhov wrote:
> On Mon, Jul 25, 2011 at 05:14:22PM +0800, Daniel Kurtz wrote:
>> On Mon, Jul 25, 2011 at 4:29 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>>
>>> On Wed, Jul 20, 2011 at 09:39:05PM +0800, djkurtz@chromium.org wrote:
>>>> From: Daniel Kurtz <djkurtz@chromium.org>
>>>>
>>>
>>> Do we know what we want to do with this gesture? Because if not I'd
>>> rather not merge it for now, until there are real users.
>>
>> And do what instead?
>> Report 5 fingers with BTN_TOOL_QUADTAP?
>>
> 
> That, or nothing... The fact that the device can report 5 finger touch
> does not mean that anybody cares about this.

The uTouch gesture stack supports up to 5 touch gestures, and although
most of them are either hard to do on a trackpad or are not possible
with this driver, I can think of uses for 5 finger tap. Unity uses four
finger tap quite effectively I believe.

There is a meaningful limit to this: five fingers on a human hand. It
seems more arbitrary to stick the protocol limit at four fingers.

-- Chase
