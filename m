From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] [v3]Input: evdev - drop partial events after emptying the buffer
Date: Tue, 5 Jan 2016 03:26:45 +0530
Message-ID: <CADYu30_y4rY7pwhhCe3tF8pKs8t7XSzaaa5-SiBmtV7Qwo_0PQ@mail.gmail.com>
References: <1451943026-1240-1-git-send-email-a.mathur@samsung.com>
	<201601050503.VzGihqCa%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f196.google.com ([209.85.214.196]:36001 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbcADV4q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2016 16:56:46 -0500
In-Reply-To: <201601050503.VzGihqCa%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, David Herrmann <dh.herrmann@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Just now sent v4. Please ignore v3.

On Tue, Jan 5, 2016 at 3:19 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Aniroop,
>
> [auto build test ERROR on input/next]
> [also build test ERROR on v4.4-rc8 next-20160104]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Aniroop-Mathur/Input-evdev-drop-partial-events-after-emptying-the-buffer/20160105-053003
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> config: avr32-atstk1006_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=avr32
>
> All errors (new ones prefixed by >>):
>
>    drivers/input/evdev.c: In function '__evdev_queue_syn_dropped':
>    drivers/input/evdev.c:195: error: request for member 'time' in something not a structure or union
>>> drivers/input/evdev.c:196: error: incompatible types in assignment
> --
>    /kbuild/src/um/drivers/input/evdev.c: In function '__evdev_queue_syn_dropped':
>    /kbuild/src/um/drivers/input/evdev.c:195: error: request for member 'time' in something not a structure or union
>>> /kbuild/src/um/drivers/input/evdev.c:196: error: incompatible types in assignment
>
> vim +196 drivers/input/evdev.c
>
>    189           * ignore partial events and if last packet is fully stored, queue
>    190           * SYN_REPORT so that clients would not ignore next full packet.
>    191           */
>    192          if (prev_ev->type != EV_SYN && prev_ev->code != SYN_REPORT) {
>    193                  client->drop_pevent = true;
>    194          } else if (prev_ev->type == EV_SYN && prev_ev->code == SYN_REPORT) {
>  > 195                  prev_ev.time = ev.time;
>  > 196                  client->buffer[client->head++] = prev_ev;
>    197                  client->head &= mask;
>    198                  client->packet_head = client->head;
>    199
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
