From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v3 0/3] input: goodix - support Goodix gt5688
Date: Fri, 15 Feb 2019 15:11:50 +0100
Message-ID: <cover.1550239328.git.agx@sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bastien Nocera <hadess@hadess.net>, Matthias Brugger <matthias.bgg@gmail.com>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Besides the support for gt5688 two more minimal changes piled up so I'm
folding these in here. One is a doc update for the goodix bindings, the
other one makes it a bit simpler to figure out configuration problems
(like lack of touchscreen-size-{x,y} in the device tree.

I've kept the original subject to (hopefully) not break the series for
patchwork. All patches can be applied independently. Series is based on
next-20190208.

Changes from v2
* Add 'dt-bindings: input: Refer to touchscreen.txt for goodix ts'
* Add 'input: goodix: Print values in case of inconsistencies'
  (sent out separtely before, no comments so far)
* Collect 'Reviewed-By' on 'input: goodix - support Goodix gt5688'

Changes from v1
* Add tested board to commit message

Guido Günther (3):
  input: goodix - support Goodix gt5688
  dt-bindings: input: Refer to touchscreen.txt for goodix ts
  input: goodix: Print values in case of inconsistencies

 .../bindings/input/touchscreen/goodix.txt          | 14 +++++++++-----
 drivers/input/touchscreen/goodix.c                 |  6 +++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.20.1
