From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Input: mpu3050: add of_match table for device-tree probing
Date: Fri, 23 Dec 2011 07:58:41 -0800
Message-ID: <CAOesGMiGJmc6FhsDcsmROUgoLD4eDFKK=LE7yYjkJn1O7oiL8Q@mail.gmail.com>
References: <1324607992-2919-1-git-send-email-olof@lixom.net>
	<20111223092246.GA7120@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52766 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757379Ab1LWP6m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Dec 2011 10:58:42 -0500
Received: by yenm11 with SMTP id m11so5828708yen.19
        for <linux-input@vger.kernel.org>; Fri, 23 Dec 2011 07:58:41 -0800 (PST)
In-Reply-To: <20111223092246.GA7120@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi,

On Fri, Dec 23, 2011 at 1:22 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Olof,
>
> On Thu, Dec 22, 2011 at 06:39:52PM -0800, Olof Johansson wrote:
>> Adding invn,mpu3050 as the initial id.
>>
>
> I believe you also need to add this to
> Documentation/devicetree/bindings/input/

For simple i2c devices that only have a name, address and possibly an
interrupt, there's no need to document a binding (it hasn't been done
in the past for the vast majority of those devices).


-Olof
