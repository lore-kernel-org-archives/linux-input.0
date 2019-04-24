From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 2/5] Input: edt-ft5x06: Document links-add property
Date: Wed, 24 Apr 2019 12:19:10 +0200
Message-ID: <20190424101913.1534-3-benjamin.gaignard@st.com>
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
 Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
index 870b8c5cce9b..38b84d2b32e6 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
@@ -60,6 +60,8 @@ Optional properties:
  - touchscreen-inverted-x  : See touchscreen.txt
  - touchscreen-inverted-y  : See touchscreen.txt
  - touchscreen-swapped-x-y : See touchscreen.txt
+ - links-add		: List of suppliers handles, suppliers will be
+			  suspended after touchscreen device and resume before it.
 
 Example:
 	polytouch: edt-ft5x06@38 {
-- 
2.15.0
