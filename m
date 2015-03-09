From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH v2 0/4] input: synaptics - report correct width and pressure values
Date: Mon, 09 Mar 2015 22:35:35 +0100
Message-ID: <1849295.uTNNWPVtNK@xps13>
References: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-kernel@vger.kernel.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, rydberg@bitmath.org, grafi@grafi.jp
List-Id: linux-input@vger.kernel.org

It was pointed out that I made a terrible mistake in 4/4 [1] of this series
and I'm going to fix it. But I have a question first.

Is there any reason why the pointer emulation takes care of ABS_PRESSURE,
but not ABS_TOOL_WIDTH?
I know for example that xf86-input-synaptics relies on both (at least the
current stable release) for the palm detection and there might be some
other userspace applications relying on it. If there's no specific reason,
I could include in this series the changes to make input-mt.c send also
ABS_TOOL_WIDTH.

Regards,
Gabriele

[1] https://bugzilla.kernel.org/show_bug.cgi?id=77161#c17
