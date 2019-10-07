From: Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/3] Add support for Melfas MMS345L touchscreen
Date: Mon,  7 Oct 2019 22:33:40 +0200
Message-ID: <20191007203343.101466-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
List-Id: linux-input@vger.kernel.org

This patch series adds support for the Melfas MMS345L touchscreen
to the mms114 driver.

MMS345L is used in the Samsung Galaxy A5 (2015) that has recently
gained mainline support [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1329c1ab0730b521e6cd3051c56a2ff3d55f21e6

Stephan Gerhold (3):
  Input: mms114 - use device_get_match_data
  dt-bindings: mms114: document melfas,mms345l binding
  Input: mms114 - add support for mms345l

 .../bindings/input/touchscreen/mms114.txt     |  3 +-
 drivers/input/touchscreen/mms114.c            | 44 +++++++++++++------
 2 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.23.0
