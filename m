From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Tue, 13 Sep 2011 09:13:49 -0500
Message-ID: <CAGzDe_Y1=1Duzr8=eE+wBEa40cD8uJ4hnE0ZzFHaKChAUUPPXg@mail.gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
	<20110913080911.GA4986@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40765 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460Ab1IMOTW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 10:19:22 -0400
Received: by yxm8 with SMTP id 8so486721yxm.19
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 07:19:20 -0700 (PDT)
In-Reply-To: <20110913080911.GA4986@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, pinglinux@gmail.com, dmitry.torokhov@gmail.com

On Tue, Sep 13, 2011 at 3:09 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> Hi Jason,
>
>> Adds INPUT_PROP_POINTER or INPUT_PROP_DIRECT as necessary to the
>> hardware supported by the Wacom driver. The DIRECT property is
>> assigned to devices with an embedded screen (i.e. touchscreens
>> and display tablets). The POINTER property is assigned to those
>> without embedded screens.
>>
>> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>> ---
>
> According to the discussion leading up to the properties interface
> (https://lkml.org/lkml/2010/12/15/263), a tablet is a direct pointer
> device, as opposed to a touchpad, which is an indirect pointer
> device. The distinction determines the direction of two-finger scroll,
> for instance. The question is then what behavior should be assigned to
> a large tablet without an embedded screen. It should have POINTER set
> for sure, but should it also have DIRECT set?

Here are all the possible combinations based on my understanding of
their intended usage.

  * Touch interface without screen should have POINTER only to
indicate pointer needed and to treat absolute coordinates as relative
movement.  Relative movement is product's default behavior as
documented in its own manual and what I think should be advertised by
default.
 * Pen interface without screen should have both POINTER and DIRECT to
indicate pointer needed and to treat absolute coordinates as absolute
movement.
 * Touch interfaces with screen should have DIRECT only to indicate no
pointer displayed and absolute coordinates as absolute movement.
 * Pen interface with screen should have DIRECT only to indicate no
pointer displayed and absolute coordinates as absolute movement.
* A Pen+Touch touchscreen (only the wacom_w8001.c), should have DIRECT
only to indicate no pointer displayed and absolute coordinates as
absolute movement.

Assuming we all agree on those combination, then in the patch the
Graphire and Intuos tablets are missing a DIRECT, the touchscreens are
correct, and the Bamboo's need to add DIRECT for the PEN interface
only.

Chris
