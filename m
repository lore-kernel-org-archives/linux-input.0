From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 2.6.36/2.6.37: broken compatibility with userspace input-utils
 ?
Date: Mon, 24 Jan 2011 23:43:38 -0500
Message-ID: <4D3E54FA.1050802@teksavvy.com>
References: <4D3C5F73.2050408@teksavvy.com> <20110124175456.GA17855@core.coreip.homeip.net> <4D3E1A08.5060303@teksavvy.com> <20110125005555.GA18338@core.coreip.homeip.net> <4D3E4DD1.60705@teksavvy.com> <20110125042016.GA7850@core.coreip.homeip.net> <4D3E5372.9010305@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:18786 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751811Ab1AYEnk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 23:43:40 -0500
In-Reply-To: <4D3E5372.9010305@teksavvy.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On 11-01-24 11:37 PM, Mark Lord wrote:
> On 11-01-24 11:20 PM, Dmitry Torokhov wrote:
>> On Mon, Jan 24, 2011 at 11:13:05PM -0500, Mark Lord wrote:
>>> On 11-01-24 07:55 PM, Dmitry Torokhov wrote:
>>>>
>>>> No, as far as I know we kept ABI intact.
>>>
>>>
>>> Okay, I hacked lsinput and input-kbd to ignore the protocol number.
>>> input-kbd is still broken: it thinks my remote control (Hauppauge)
>>> has only ten buttons, and won't allow me to remap codes larger than 10.
>>>
>>> I've now hacked around that too, but without determining exactly
>>> where the interface got broken.
>>>
>>> Ugh.
>>>
>>
>> Where are the sources? I can take a look...
> 
> I used "apt-get source input-utils" under Ubuntu-10.10.
> The problem seems to be here somewhere:
> 
> static struct kbd_map* kbd_map_read(int fd)
> {
>         struct kbd_entry entry;
>         struct kbd_map *map;
>         int rc;
> 
>         map = malloc(sizeof(*map));
>         memset(map,0,sizeof(*map));
>         for (map->size = 0; map->size < 65536; map->size++) {
>                 entry.scancode = map->size;
>                 entry.keycode  = KEY_RESERVED;
>                 rc = ioctl(fd, EVIOCGKEYCODE, &entry);
>                 if (rc < 0) {
>                         break;
...
> }
> 
> This results in (map->size==10) for 2.6.36+ (wrong),
> and a much larger map->size for 2.6.35 and earlier.
> 
> So perhaps EVIOCGKEYCODE has changed?

I hacked input-kbd to ignore the map->size calculated above
when writing a new map.. seems to work.  Weird that the old
method stopped working with 2.6.36, though.

I'm using this with ir-kbd-i2c.c as the hardware driver
for the hauppauge R/C interface on a PVR-250 card.

Hey.. perhaps you may also know where in the code this thing
is being forced to a repeat rate of about 4 times/sec max?
I'd like the remote to be slightly faster that this,
but my 2.5.35 (and earlier) hacks to ir-kbd-i2c now don't
work for repeat intervals less than approx 220msecs.

Cheers!
