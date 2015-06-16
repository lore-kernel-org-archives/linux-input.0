From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [input:next 1215/1216] drivers/tty/vt/keyboard.c:994:2: warning:
 (near initialization for 'kbd_led_triggers[0].trigger')
Date: Wed, 17 Jun 2015 00:01:22 +0200
Message-ID: <20150616220122.GV2965@type.youpi.perso.aquilenet.fr>
References: <201506170453.xHm7stex%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]:33198 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbFPWKJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 18:10:09 -0400
Content-Disposition: inline
In-Reply-To: <201506170453.xHm7stex%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

kbuild test robot, le Wed 17 Jun 2015 04:02:55 +0800, a =E9crit :
>    drivers/tty/vt/keyboard.c:975:20: error: 'struct led_classdev' has=
 no member named 'trigger'
>       container_of(cdev->trigger, struct kbd_led_trigger, trigger);

Right, it doesn't have it when CONFIG_LEDS_TRIGGERS is not defined.
So the condition in keyboard.c should rather be
IS_ENABLED(CONFIG_INPUT_LEDS) && IS_ENABLED(CONFIG_LEDS_TRIGGERS).

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
