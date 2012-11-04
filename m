From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] HID: microsoft, fix invalid rdesc for 3k kbd
Date: Sun, 04 Nov 2012 23:37:29 +0100
Message-ID: <5096EE29.8090304@suse.cz>
References: <1350646126-28537-1-git-send-email-jslaby@suse.cz> <CAMuHMdWzNxhs1+14qwr0=G+_uGVWm9QKb4wBDBy-6rx5+pxv7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33824 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab2KDWhd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Nov 2012 17:37:33 -0500
In-Reply-To: <CAMuHMdWzNxhs1+14qwr0=G+_uGVWm9QKb4wBDBy-6rx5+pxv7w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 11/04/2012 10:06 PM, Geert Uytterhoeven wrote:
> On Fri, Oct 19, 2012 at 1:28 PM, Jiri Slaby <jslaby@suse.cz> wrote:
>> +       if ((quirks & MS_RDESC_3K) && *rsize == 106 &&
>> +                       !memcmp((char []){ 0x19, 0x00, 0x29, 0xff },
>> +                               &rdesc[94], 4)) {
> 
> Which version of gcc are you using?

4.7.1. But that indeed fails too if memcmp is a macro. This is of course
not the case for x86, so that I didn't hit that. I will post a patch to
change this to standard array accesses. (This looked prettier though.)

@Greg: please drop that patch from the stable queues for now.

thanks,
-- 
js
suse labs
