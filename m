From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 08/12] input: keypad-matrix: tell GPIO pins from matrix
 lines
Date: Mon, 24 Jun 2013 17:26:17 -0600
Message-ID: <51C8D599.2010706@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-9-git-send-email-gsi@denx.de> <51C4C87B.3050300@wwwdotorg.org> <20130622100052.GH24305@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59139 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab3FXX0U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jun 2013 19:26:20 -0400
In-Reply-To: <20130622100052.GH24305@book.gsilab.sittig.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/22/2013 04:00 AM, Gerhard Sittig wrote:
> On Fri, Jun 21, 2013 at 15:41 -0600, Stephen Warren wrote:
>>
>> On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
>>
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
>>
>>> +The driver assumes that all interconnections of the matrix can potentially
>>> +contain a button, and will submit scan and key code events to the input
>>> +subsystem.  By default the keypad matrix dimenstions are automatically
>>> +derived from the GPIO pin specifications.  Optionally device tree
>>> +information can override the keypad matrix dimension data, e.g. when not
>>> +all of the potentially available physical connections are used to create
>>> +the logical keypad matrix.
>>
>> Ignoring the binary encoding in the next patch, why would someone ever
>> define more row GPIOs that there are rows (or similarly for columns)?
>>
>> On its own, I don't think this patch is needed.
> 
> Well, the keypad's property (remember the layering between keypad
> and keymap) has already been there, I just made the matrix keypad
> driver actually use the keymap's DT parse call.
> 
> Regarding the usefulness of the patch in the absence of binary
> encodings which only later get introduced:  I can't tell how much
> of a stretch it's going to get perceived as, but I suggested
> this:
> 
> A .dtsi may specify the GPIO pins for a keypad attachment (say,
> the SoC's or module's "potential to drive a matrix", the physical
> perspective), while boards' .dts files may specify the keymap and
> its specific layout (the logical matrix description).

In this case, I'd say that the row-/column-GPIOs should only be
specified by the .dts/.dtsi file for the HW that actually commits the
GPIOs to that purpose.

So in your example, the .dtsi file shouldn't specify which GPIOs to use,
since the SoC (or base-board) doesn't define that; only the HW module
which actually contains the keypad does, and hence only the .dts file
for that piece of HW should specify the GPIOs.

I suppose that approach doesn't handle a board with a generic keypad
controller socket though; the user could plug in anything they want, and
wouldn't want to have to re-write the board .dts file just to specify
their keymap.

Looking at this from the approach of the keymap data: Why does the DT
need to say "these columns are used" or "these rows are used"? That data
is already available from a simple search of the keymap for the various
row-/column-IDs. Let the driver or keymap parser calculate the set of
valid rows/columns when the keymap is installed. With this approach, you
could even get far more optimal. On some Tegra boards, there end up
being rather tri-angular keymaps, where key positions (0, 0), (0, 1),
(0, 2), (1, 1), (1, 2), (2, 2) end up being used. In this scenario,
detailed investigation of the keymap would reveal:

* Only scan columns 0..2
* For column 0, scan rows 0..2
* For column 1, scan rows 1..2
* For columm 2, scan row 2.
