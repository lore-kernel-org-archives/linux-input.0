From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [RESEND PATCH V4 0/1]  Add OnKey support for DA9063
Date: Thu, 4 Jun 2015 12:02:32 +0100
Message-ID: <cover.1433415752.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Kosina <jkosina@suse.cz>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Hello,

This is a resend, now adding Andrew Morton and Jiri Kosina with the hope
it might help to unblock this patch.

The OnKey patch originally reviewed by Dmitry Torokhov and re-submitted in
return -- it has been resent several times in the past six weeks but has had
no further responses to any e-mails.

- https://lkml.org/lkml/2015/6/3/99

I would like to promote this last remaining OnKey patch to other maintainers
in the hierarchy with the hope I can get a reply.

The original patch set for adding OnKey driver support for the Dialog
Semiconductor DA9063 PMIC contained MFD core support, DT bindings and
the OnKey driver itself.

All files have been reviewed by the maintainers and my reponses have been
sent quickly. Two out of the three patches in this set were Acked and have
already been applied to linux-next kernel:

a5df460 mfd: dt: Add bindings for DA9063 OnKey
d497c625 mfd: da9063: Add support for OnKey driver

This is the remaining patch being resent:

[RESEND PATCH V4 1/1]: kernel driver onkey support for DA9063

This particular OnKey patch will only support the DA9063 PMIC. If this patch
makes it into the kernel it was the request of the maintainers and is my
intention to use this OnKey driver as the starting point for other Dialog
Semiconductor chips which also use a functionally similar OnKey block.

One of these PMIC chips is currently under submission to the kernel and the
MFD part has already been reviewed and my replies for that one sent. I expect
this hanging patch for OnKey will eventually block further development in
other Dialog chips: this is another reason I have for wanting to promote the
DA9063 OnKey driver further.

I would like to move this driver development forward again, so if there are
any issues relating to this OnKey driver I would very much appreciate any
response so I can unblock things.
 
Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (1):
  input: misc: da9063: OnKey driver

 drivers/input/misc/Kconfig        |  10 ++
 drivers/input/misc/Makefile       |   1 +
 drivers/input/misc/da9063_onkey.c | 227 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+)
 create mode 100644 drivers/input/misc/da9063_onkey.c

-- 
end-of-patch for RESEND PATCH V4
