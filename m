From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH next] Input: alps_get_pkt_id_ss4_v2() can be static
Date: Sun, 12 Apr 2015 15:53:05 -0700
Message-ID: <20150412225101.GA15638@dtor-ws>
References: <201504110955.4uEmNJDX%fengguang.wu@intel.com>
 <20150411012111.GA64853@snb>
 <5528BFEA.5080103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5528BFEA.5080103@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, Masaki Ota <masaki.ota@jp.alps.com>, kbuild-all@01.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Apr 11, 2015 at 08:32:10AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 04/11/2015 03:21 AM, kbuild test robot wrote:
> >
> >Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> 
> Ack, these should all be static:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Dmitry, can you please merge this one ?

Yep, applied, thank you.

> 
> Regards,
> 
> Hans
> 
> >---
> >  alps.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> >index ad741c0..3ef93ff 100644
> >--- a/drivers/input/mouse/alps.c
> >+++ b/drivers/input/mouse/alps.c
> >@@ -1093,7 +1093,7 @@ static void alps_process_packet_v7(struct psmouse *psmouse)
> >  		alps_process_touchpad_packet_v7(psmouse);
> >  }
> >
> >-unsigned char alps_get_pkt_id_ss4_v2(unsigned char *byte)
> >+static unsigned char alps_get_pkt_id_ss4_v2(unsigned char *byte)
> >  {
> >  	unsigned char pkt_id = SS4_PACKET_ID_IDLE;
> >
> >@@ -2340,7 +2340,7 @@ static int alps_get_otp_values_ss4_v2(struct psmouse *psmouse,
> >  	return 0;
> >  }
> >
> >-int alps_update_device_area_ss4_v2(unsigned char otp[][4],
> >+static int alps_update_device_area_ss4_v2(unsigned char otp[][4],
> >  				   struct alps_data *priv)
> >  {
> >  	int num_x_electrode;
> >@@ -2365,7 +2365,7 @@ int alps_update_device_area_ss4_v2(unsigned char otp[][4],
> >  	return 0;
> >  }
> >
> >-int alps_update_btn_info_ss4_v2(unsigned char otp[][4], struct alps_data *priv)
> >+static int alps_update_btn_info_ss4_v2(unsigned char otp[][4], struct alps_data *priv)
> >  {
> >
> >  	unsigned char is_btnless;
> >

-- 
Dmitry
