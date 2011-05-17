From: Chase Douglas <chase.douglas@canonical.com>
Subject: 35022: hid-magicmouse broken
Date: Tue, 17 May 2011 08:40:24 -0400
Message-ID: <4DD26CB8.7070409@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:42219 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab1EQMk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 08:40:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Jiri,

I've received a few emails about the magicmouse driver being broken on
2.6.39:

https://bugzilla.kernel.org/show_bug.cgi?id=35022

It seems hid_output_raw_report() is returning a different (incorrect?)
value than in the past. Do you know what might be going on?

Thanks!

-- Chase
