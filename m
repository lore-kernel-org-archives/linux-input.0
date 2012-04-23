From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv3 1/2] drivers: input: keypad: Add device tree support
Date: Mon, 23 Apr 2012 10:41:41 -0600
Message-ID: <4F958645.4080200@wwwdotorg.org>
References: <1335194839-30193-1-git-send-email-sourav.poddar@ti.com>	<4F95749E.40708@wwwdotorg.org> <CAKdam541af1bU8_64gTZva9VS0R3dTR=3L3J50o9HgHH+WaPYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdam541af1bU8_64gTZva9VS0R3dTR=3L3J50o9HgHH+WaPYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>
List-Id: linux-input@vger.kernel.org

On 04/23/2012 09:40 AM, Poddar, Sourav wrote:
> Hi Stephen,
> 
> On Mon, Apr 23, 2012 at 8:56 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 04/23/2012 09:27 AM, Sourav Poddar wrote:
>>> Update the Documentation with omap4 keypad device tree
>>> binding information.
>>> Add device tree support for omap4 keypad driver.
>>
>> Shouldn't this use the already-defined matrix keyboard bindings at
>> Documentation/devicetree/bindings/input/matrix-keymap.txt?
>>
> True, that is one way of describing the linux-keymap, but i think it can be
> done  either ways.

Well, there certainly is more than one way to represent the data.
However, it'd be best to avoid creating new bindings for every piece of
hardware when there's already an existing binding that can be used. By
reusing the binding, different HW can be configured in the same way thus
re-using any knowledge someone has of the binding.

> Are you hinting at getting rid of Documentation for each seperate modules and
> just use a single  Documentation/devicetree/bindings/input/matrix-keymap.txt?

You'd probably still need a device-specific binding in order to define
which compatible values were necessary, which reg values were necessary,
to reference the common binding documentation, to document any required
additional custom properties, and document any limitations. For example,
see how Olof wrote Documentation/devicetree/bindings/input/tegra-kbc.txt
based on the common matrix keyboard binding.
