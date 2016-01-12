From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 2/2] input: gpio-keys: add support to name the gpio-keys
Date: Tue, 12 Jan 2016 20:54:08 +0530
Message-ID: <56951A98.40502@nvidia.com>
References: <1452598370-28509-1-git-send-email-ldewangan@nvidia.com> <1452598370-28509-2-git-send-email-ldewangan@nvidia.com> <20160112144301.GA30932@rob-hp-laptop> <569513E6.60608@nvidia.com> <CAL_Jsq+ZLVNXVnQX+fYGjhqAx6aFrPNgBBXbPGTKrWoY52vMvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14641 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbcALPei (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2016 10:34:38 -0500
In-Reply-To: <CAL_Jsq+ZLVNXVnQX+fYGjhqAx6aFrPNgBBXbPGTKrWoY52vMvw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


On Tuesday 12 January 2016 08:53 PM, Rob Herring wrote:
> On Tue, Jan 12, 2016 at 8:55 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
>> On Tuesday 12 January 2016 08:13 PM, Rob Herring wrote:
>>> On Tue, Jan 12, 2016 at 05:02:50PM +0530, Laxman Dewangan wrote:

> So label is exactly for this purpose of defining user meaningful names.
>
Yes, I can use the label for name. I will update the patch.

Just for understanding, is "label" is better property name to pass the 
specific name?


