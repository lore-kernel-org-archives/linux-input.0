From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] Input: matrix-keypad - Add device tree support
Date: Fri, 02 Nov 2012 09:03:07 -0600
Message-ID: <5093E0AB.7090308@wwwdotorg.org>
References: <1351684471-29369-1-git-send-email-anilkumar@ti.com> <50914433.1070805@wwwdotorg.org> <331ABD5ECB02734CA317220B2BBEABC13EA5E80B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43766 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab2KBPDK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Nov 2012 11:03:10 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA5E80B@DBDE01.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "dgdunix@gmail.com" <dgdunix@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 11/02/2012 02:21 AM, AnilKumar, Chimata wrote:
> On Wed, Oct 31, 2012 at 21:00:59, Stephen Warren wrote:
>> On 10/31/2012 05:54 AM, AnilKumar Ch wrote:
>>> Add device tree support to matrix keypad driver and usage details
>>> are added to device tree documentation. Driver was tested on AM335x
>>> EVM.
>>
>>> diff --git a/Documentation/devicetree/bindings/input/matrix-keypad.txt b/Documentation/devicetree/bindings/input/matrix-keypad.txt
>>> new file mode 100644
>>
>>> +- compatible:		Should be "gpio-matix-keypad"
>>
>> There's a typo there.
>>
>> Given that compatible value, shouldn't the file be named
>> gpio-matrix-keypad.txt then?
> 
> Stephen,
> 
> Thanks for the comments.
> 
> I agree and I have same thing in my mind but the driver name
> is matrix-keypad.c. And I think we have to change the driver
> file names as well. (drivers/../matrix_keypad.c, linux/input/
> matrix_keypad.h).

I don't think there's any requirement that the Linux driver source
filename needs to match the DT binding compatible value in any way.
Given the bindings are OS-agnostic, naming the binding file based on the
compatible value seems better than naming the binding based on the Linux
driver name when there's a discrepancy. I see you've renamed the file in
V3, so everything's fine.
