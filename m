From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/3] input: touchscreen: ad7879: fix default x/y axis assignment
Date: Mon, 25 Jan 2016 19:04:36 -0800
Message-ID: <1453777477-29706-2-git-send-email-stefan@agner.ch>
References: <1453777477-29706-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453777477-29706-1-git-send-email-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-input@vger.kernel.org

The measurements read from the controller which are temporary stored
in conversion_data, are interpreted wrong. The first measurement X+
contains the Y position, and the second measurement Y+ the X position
(see also Table 11 Register Table in the data sheet).

The problem is already known and a swap option has been introduced:
commit 6680884a4420 ("Input: ad7879 - add option to correct xy axis")

However, with that the meaning of the new boolean is inverted since
the underlying values are already swapped. With this change, a true
in swap_xy actually swaps the two axis.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Michael,

It seems that swap_xy is not used in any board which is in mainline,
hence swap_xy is always false. Therefore, up until now all boards
actually used swapped axis. However, I doubt that the blackfin boards
really have those axis swapped, it is probably more likely that the
userspace calibration took care of it.

However, if they are really swapped, we should set the swap_xy flag
to 1 for those board...

Do you happen to now what is the case with those boards?
