From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC] Synchronization Issue in hid_hw_start()
Date: Wed, 29 Jun 2011 15:20:30 +0200
Message-ID: <BANLkTinz5iSCCGNC-U8TVrZ7xbc4biF_jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58997 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab1F2NUb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 09:20:31 -0400
Received: by vws1 with SMTP id 1so865820vws.19
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 06:20:30 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi

The comment of hid_hw_start() (hid.h) mentions:
 * Call this in probe function *after* hid_parse. This will setup HW buffers
 * and start the device (if not deffered to device open). hid_hw_stop must be
 * called if this was successful.
Especially the part in brackets allows the low-level driver to start
the device without waiting for hid_hw_open() (bluetooth hid does
this). However, hid_hw_start() does not synchronize hid and input
startup, but instead first starts the hid layer followed by input. If
the HID layer reports an event before the input layer is started,
HIDINPUT will send the event to a nonexisting input device or may even
dereference an invalid address.
Same thing in hid_hw_stop().

An easy fix would be adding an atomic_t "ready" variable to the
hid_device that is set to 1 after successful setup and
hid_input_report must ignore every input until ready is 1. However,
this does not work for hid_hw_stop() because we can't determine
whether there is already a thread running inside hid_input_report() or
similar.

A more complex fix is a rwlock. hid_hw_start() locks it as writer and
hid_input_report() and all other depending functions lock it as
reader. We would still need something like a "ready" variable, but
synchronization is also possible on hid_hw_stop() this way.

Another more complex fix would be an input function like
input_stop_reports() which will prevent the input instance from
reporting any more events but still allow us to send events to it.
Similar input_start_reports() for startup-synchronization. So we could
register the input layer but prevent it from sending reports. Then we
would start up the hid layer and after that we would start input
reports. Same thing on shutdown...

Any ideas?
Regards
David
