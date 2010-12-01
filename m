From: simon@mungewell.org
Subject: Rewriting wheels HID descriptor for complete functionality
Date: Wed, 1 Dec 2010 13:23:15 -0500
Message-ID: <e0bdb04c6bf793ed464934fd4f8b663e.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:46265 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0LASXR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 13:23:17 -0500
Received: from localhost ([127.0.0.1] helo=host171.canaca.com)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1PNrKl-0001Ui-MW
	for linux-input@vger.kernel.org; Wed, 01 Dec 2010 13:23:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I am working on a driver for a Logitech gaming wheel where the HID
descriptor presents a 'joystick' with X and Y axis, the Y is a combined
acc/brake value even though the wheel has separate paddles for each.

There are 'vendor defined' variables for both the acc/brake within the HID
descriptor, but these are not (by Linux) tied to their function.

On the Windows, the specialised Logitech driver gives the option to use
either combined or separate acc/brake.

I am considering re-writing the HID descriptor to expose these separate
values as 'proper' axis, as they would provide both better resolution and
better functionality (ie. left foot braking).

Q1. Is this an acceptable thing to do?

Q2. In the case where there is significant change to the HID descriptor,
is it OK to just re-write the whole block (rather than patch/swap a couple
of bytes)?

Q3. In re-writing descriptor for the combined acc/brake. Is there a
particular 'variable' I should change it to (X, Y and Z would already be
used), or should I just make it 'vendor defined'?

Thanks in advance,
Simon
(aka Mungewell)

