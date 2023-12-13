Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1075DB;
	Wed, 13 Dec 2023 13:48:12 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.04,273,1695654000"; 
   d="scan'208";a="186385645"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2023 06:48:10 +0900
Received: from localhost.localdomain (unknown [10.26.240.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D755A40BB731;
	Thu, 14 Dec 2023 06:48:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-input@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/4] Add polling support for DA9063 onkey driver
Date: Wed, 13 Dec 2023 21:47:59 +0000
Message-Id: <20231213214803.9931-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some platforms (eg: RZ/{G2UL,Five} SMARC EVK), there is no IRQ
populated by default. This patch series aims to add polling support
by parsing the polling interval from device tree and then detect
short and long key press.

v1->v2:
 * Add a new patch for dropping redundant prints in probe()
 * Fixed typo in commit description for patch#3.
 * Updated the print message for irq allocation failure.
 * Updated commit description for patch#4
 * Fixed the logical mistake for optional IRQ handling.

Biju Das (4):
  Input: da9063 - Simplify obtaining OF match data
  Input: da9063 - Drop redundant prints in probe()
  Input: da9063 - Use dev_err_probe()
  Input: da9063 - Add polling support

 drivers/input/misc/da9063_onkey.c | 146 +++++++++++++++++-------------
 1 file changed, 84 insertions(+), 62 deletions(-)

-- 
2.25.1

