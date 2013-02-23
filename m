From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 0/4] Input: auo_pixcir_ts - add devicetree support
Date: Sat, 23 Feb 2013 12:55:23 +0100
Message-ID: <201302231255.23772.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Some small cleanups needed and the parsing of the dt data.

Heiko Stuebner (4):
  Input: auo-pixcir-ts - set input direction for interrupt gpio
  Input: auo-pixcir-ts - handle reset gpio directly
  Input: auo_pixcir_ts - keep own pointer to platform_data
  Input: auo_pixcir_ts - add devicetree support

 .../bindings/input/touchscreen/auo_pixcir_ts.txt   |   30 ++++++
 drivers/input/touchscreen/auo-pixcir-ts.c          |  104 +++++++++++++++++--
 include/linux/input/auo-pixcir-ts.h                |    4 +-
 3 files changed, 124 insertions(+), 14 deletions(-)
 create mode 100644 
Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt

-- 
1.7.2.3
