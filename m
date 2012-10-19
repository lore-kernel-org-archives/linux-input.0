From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] Input: matrix-keypad - Add device tree support
Date: Fri, 19 Oct 2012 12:36:11 +0530
Message-ID: <1350630373-24279-1-git-send-email-anilkumar@ti.com>
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
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, dgdunix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Add device tree support to matrix keypad driver by adding all necessary
DT parameters. Also added device tree bindings.

These patches were tested on AM335x-EVM with DT patches, DT patches
will be submitted once these are accepted.

AnilKumar Ch (2):
  Input: matrix-keypad - remove const from pointer to array of gpios
  Input: matrix-keypad - Add device tree support

 .../devicetree/bindings/input/matrix-keypad.txt    |   52 ++++++++++
 drivers/input/keyboard/matrix_keypad.c             |  104 +++++++++++++++++++-
 include/linux/input/matrix_keypad.h                |    4 +-
 3 files changed, 157 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/matrix-keypad.txt

-- 
1.7.9.5
