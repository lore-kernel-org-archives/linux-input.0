From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 4/5] Input: goodix: Document links-add property
Date: Wed, 24 Apr 2019 12:19:12 +0200
Message-ID: <20190424101913.1534-5-benjamin.gaignard@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424101913.1534-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, hadess@hadess.net, frowand.list@gmail.com, m.felsch@pengutronix.de, agx@sigxcpu.org, yannick.fertre@st.com, arnd@arndb.de
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-input@vger.kernel.org

Explain the purpose of links_add property.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 8cf0b4d38a7e..0447151608c6 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -24,6 +24,8 @@ Optional properties:
  - touchscreen-size-x
  - touchscreen-size-y
  - touchscreen-swapped-x-y
+ - links-add		: List of suppliers handles, suppliers will be
+			  suspended after goodix device and resume before it.
 
 The touchscreen-* properties are documented in touchscreen.txt in this
 directory.
-- 
2.15.0
