From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: How to indicate hover touch when exact distance unknown?
Date: Tue, 23 Sep 2014 20:52:12 +0200
Message-ID: <5421C15C.6030302@euromail.se>
References: <CAG_cf+dJfiqW_V1k4MfGMBNUK9Kgc4=9BPAuum7dbs6rkmAgrQ@mail.gmail.com> <20140923145916.GA3110@mail.corp.redhat.com> <20140923162811.GB40700@core.coreip.homeip.net> <CAG_cf+fuugk4QK_1BtWnJWzunWT4QeSus_2cuPpYH_8UCUjMOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:60366 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbaIWTKg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 15:10:36 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h31.telenor.se (Postfix) with ESMTP id 573B8241F6
	for <linux-input@vger.kernel.org>; Tue, 23 Sep 2014 20:51:26 +0200 (CEST)
In-Reply-To: <CAG_cf+fuugk4QK_1BtWnJWzunWT4QeSus_2cuPpYH_8UCUjMOQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew de los Reyes <andrew-vger@gizmolabs.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, hdegoede@redhat.com, jikos@jikos.cz, David Herrmann <dh.herrmann@gmail.com>, peter.hutterer@who-t.net, Linux Input <linux-input@vger.kernel.org>

>>> So I am not very happy with having a new
>>> tool. In the end, it may also disturb older clients which will not know
>>> what to do with HOVER.
>>> And the ABS_MT_DISTANCE approach used to be fully retro-compatible
>>> (assuming that the hovering distance is small enough for the user not to
>>> detect it).
>>
>> Except that if we start getting devices that can actually tell the
>> distance we'd need special casing 0/1 handling, no?

Logically, a hovering object which does not support real distance reporting
would simply be present in the contact list but have ABS_MT_TOUCH = 0. However,
I do not think all layers of the stack supports this notion.

Henrik

