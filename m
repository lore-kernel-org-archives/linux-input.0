From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Wacom based devices and the mt kernel protocol.
Date: Fri, 18 Jun 2010 13:20:46 +0200
Message-ID: <AANLkTinq_3P-QrTqsEdtyMbBtc9EXhahclER_4s5_Kx2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34098 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760973Ab0FRLVI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 07:21:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, pingc@wacom.com, Chase Douglas <chase.douglas@canonical.com>, Rafi Rubin <rafi@seas.upenn.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi,

Now we can find many multitouch devices based on wacom Wacom panel/digitizer
Bamboo Pen&Touch, HP tm2, Fujitsu LifeBook T4410 & T4310, etc...

it seems that these devices are supported in some way in Linux Kernel,
but I want to know if they are compliant with the MT Linux protocol.
N-Trig based devices and Stantum ones are the most compliant, so Wacom
situation needs to be clarified specially considering they are HID
devices (meaning similar to the others devices which respect the
protocol). This impact very much the decision of a Linux user wanting
to buy wacom mt device.

Ping can you clarifie the situation of wacom based devices ?

Thanks,

ik.

On Tue, Jun 15, 2010 at 7:01 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>
> g number of intelligent multi-contact and
> multi-user devices, the need to send digested, filtered information
> from a set of different sources within the same device is imminent.
> This patch adds the concept of slots to the MT protocol. The slots
> enumerate a set of identified sources, such that all MT events
