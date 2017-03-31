From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/4] Input: synaptics - use u8 instead of unsigned char
Date: Fri, 31 Mar 2017 11:46:23 +0200
Message-ID: <20170331094623.GM22683@mail.corp.redhat.com>
References: <20170325060409.40558-1-dmitry.torokhov@gmail.com>
 <20170325060409.40558-4-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753535AbdCaJqb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 05:46:31 -0400
Content-Disposition: inline
In-Reply-To: <20170325060409.40558-4-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

On Mar 24 2017 or thereabouts, Dmitry Torokhov wrote:
> The rest of the kernel uses u8, u16, etc for data coming form hardware,
> let's switch ti using u8 here as well.
> 
> Also turn pkt_type into an enum.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

The series looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/mouse/synaptics.c | 60 ++++++++++++++++++++---------------------
>  drivers/input/mouse/synaptics.h | 22 ++++++++-------
>  2 files changed, 42 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 224269c849bb..0b99c8732306 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -79,9 +79,9 @@
>  /*
>   * Set the synaptics touchpad mode byte by special commands
>   */
> -static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
> +static int synaptics_mode_cmd(struct psmouse *psmouse, u8 mode)
>  {
> -	unsigned char param[1];
> +	u8 param[1];
>  	int error;
>  
>  	error = psmouse_sliced_command(psmouse, mode);
> @@ -99,7 +99,7 @@ static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
>  int synaptics_detect(struct psmouse *psmouse, bool set_properties)
>  {
>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
> -	unsigned char param[4];
> +	u8 param[4];
>  
>  	param[0] = 0;
>  
> @@ -186,12 +186,11 @@ static const char * const forcepad_pnp_ids[] = {
>  /*
>   * Send a command to the synpatics touchpad by special commands
>   */
> -static int synaptics_send_cmd(struct psmouse *psmouse,
> -			      unsigned char c, unsigned char *param)
> +static int synaptics_send_cmd(struct psmouse *psmouse, u8 cmd, u8 *param)
>  {
>  	int error;
>  
> -	error = psmouse_sliced_command(psmouse, c);
> +	error = psmouse_sliced_command(psmouse, cmd);
>  	if (error)
>  		return error;
>  
> @@ -261,7 +260,7 @@ static int synaptics_firmware_id(struct psmouse *psmouse,
>  static int synaptics_query_modes(struct psmouse *psmouse,
>  				 struct synaptics_device_info *info)
>  {
> -	unsigned char bid[3];
> +	u8 bid[3];
>  	int error;
>  
>  	/* firmwares prior 7.5 have no board_id encoded */
> @@ -345,7 +344,7 @@ static int synaptics_capability(struct psmouse *psmouse,
>  static int synaptics_resolution(struct psmouse *psmouse,
>  				struct synaptics_device_info *info)
>  {
> -	unsigned char resp[3];
> +	u8 resp[3];
>  	int error;
>  
>  	if (SYN_ID_MAJOR(info->identity) < 4)
> @@ -537,7 +536,7 @@ static void synaptics_apply_quirks(struct psmouse *psmouse,
>  
>  static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
>  {
> -	static unsigned char param = 0xc8;
> +	static u8 param = 0xc8;
>  	struct synaptics_data *priv = psmouse->private;
>  	int error;
>  
> @@ -609,7 +608,7 @@ static void synaptics_set_rate(struct psmouse *psmouse, unsigned int rate)
>  /*****************************************************************************
>   *	Synaptics pass-through PS/2 port support
>   ****************************************************************************/
> -static int synaptics_pt_write(struct serio *serio, unsigned char c)
> +static int synaptics_pt_write(struct serio *serio, u8 c)
>  {
>  	struct psmouse *parent = serio_get_drvdata(serio->parent);
>  	u8 rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
> @@ -648,13 +647,12 @@ static void synaptics_pt_stop(struct serio *serio)
>  	serio_continue_rx(parent->ps2dev.serio);
>  }
>  
> -static int synaptics_is_pt_packet(unsigned char *buf)
> +static int synaptics_is_pt_packet(u8 *buf)
>  {
>  	return (buf[0] & 0xFC) == 0x84 && (buf[3] & 0xCC) == 0xC4;
>  }
>  
> -static void synaptics_pass_pt_packet(struct serio *ptport,
> -				     unsigned char *packet)
> +static void synaptics_pass_pt_packet(struct serio *ptport, u8 *packet)
>  {
>  	struct psmouse *child = serio_get_drvdata(ptport);
>  
> @@ -717,7 +715,7 @@ static void synaptics_pt_create(struct psmouse *psmouse)
>   *	Functions to interpret the absolute mode packets
>   ****************************************************************************/
>  
> -static void synaptics_parse_agm(const unsigned char buf[],
> +static void synaptics_parse_agm(const u8 buf[],
>  				struct synaptics_data *priv,
>  				struct synaptics_hw_state *hw)
>  {
> @@ -746,7 +744,7 @@ static void synaptics_parse_agm(const unsigned char buf[],
>  	}
>  }
>  
> -static void synaptics_parse_ext_buttons(const unsigned char buf[],
> +static void synaptics_parse_ext_buttons(const u8 buf[],
>  					struct synaptics_data *priv,
>  					struct synaptics_hw_state *hw)
>  {
> @@ -758,7 +756,7 @@ static void synaptics_parse_ext_buttons(const unsigned char buf[],
>  	hw->ext_buttons |= (buf[5] & ext_mask) << ext_bits;
>  }
>  
> -static int synaptics_parse_hw_state(const unsigned char buf[],
> +static int synaptics_parse_hw_state(const u8 buf[],
>  				    struct synaptics_data *priv,
>  				    struct synaptics_hw_state *hw)
>  {
> @@ -834,7 +832,7 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
>  		} else if (SYN_CAP_MIDDLE_BUTTON(priv->info.capabilities)) {
>  			hw->middle = ((buf[0] ^ buf[3]) & 0x01) ? 1 : 0;
>  			if (hw->w == 2)
> -				hw->scroll = (signed char)(buf[1]);
> +				hw->scroll = (s8)buf[1];
>  		}
>  
>  		if (SYN_CAP_FOUR_BUTTON(priv->info.capabilities)) {
> @@ -1149,18 +1147,18 @@ static void synaptics_process_packet(struct psmouse *psmouse)
>  	input_sync(dev);
>  }
>  
> -static int synaptics_validate_byte(struct psmouse *psmouse,
> -				   int idx, unsigned char pkt_type)
> +static bool synaptics_validate_byte(struct psmouse *psmouse,
> +				    int idx, enum synaptics_pkt_type pkt_type)
>  {
> -	static const unsigned char newabs_mask[]	= { 0xC8, 0x00, 0x00, 0xC8, 0x00 };
> -	static const unsigned char newabs_rel_mask[]	= { 0xC0, 0x00, 0x00, 0xC0, 0x00 };
> -	static const unsigned char newabs_rslt[]	= { 0x80, 0x00, 0x00, 0xC0, 0x00 };
> -	static const unsigned char oldabs_mask[]	= { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
> -	static const unsigned char oldabs_rslt[]	= { 0xC0, 0x00, 0x00, 0x80, 0x00 };
> -	const char *packet = psmouse->packet;
> +	static const u8 newabs_mask[]	  = { 0xC8, 0x00, 0x00, 0xC8, 0x00 };
> +	static const u8 newabs_rel_mask[] = { 0xC0, 0x00, 0x00, 0xC0, 0x00 };
> +	static const u8 newabs_rslt[]	  = { 0x80, 0x00, 0x00, 0xC0, 0x00 };
> +	static const u8 oldabs_mask[]	  = { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
> +	static const u8 oldabs_rslt[]	  = { 0xC0, 0x00, 0x00, 0x80, 0x00 };
> +	const u8 *packet = psmouse->packet;
>  
>  	if (idx < 0 || idx > 4)
> -		return 0;
> +		return false;
>  
>  	switch (pkt_type) {
>  
> @@ -1176,19 +1174,21 @@ static int synaptics_validate_byte(struct psmouse *psmouse,
>  
>  	default:
>  		psmouse_err(psmouse, "unknown packet type %d\n", pkt_type);
> -		return 0;
> +		return false;
>  	}
>  }
>  
> -static unsigned char synaptics_detect_pkt_type(struct psmouse *psmouse)
> +static enum synaptics_pkt_type
> +synaptics_detect_pkt_type(struct psmouse *psmouse)
>  {
>  	int i;
>  
> -	for (i = 0; i < 5; i++)
> +	for (i = 0; i < 5; i++) {
>  		if (!synaptics_validate_byte(psmouse, i, SYN_NEWABS_STRICT)) {
>  			psmouse_info(psmouse, "using relaxed packet validation\n");
>  			return SYN_NEWABS_RELAXED;
>  		}
> +	}
>  
>  	return SYN_NEWABS_STRICT;
>  }
> @@ -1393,7 +1393,7 @@ static int synaptics_reconnect(struct psmouse *psmouse)
>  {
>  	struct synaptics_data *priv = psmouse->private;
>  	struct synaptics_device_info info;
> -	unsigned char param[2];
> +	u8 param[2];
>  	int retry = 0;
>  	int error;
>  
> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
> index 7a998fbfa6b0..fc00e005c611 100644
> --- a/drivers/input/mouse/synaptics.h
> +++ b/drivers/input/mouse/synaptics.h
> @@ -137,15 +137,17 @@
>  #define SYN_PS_SET_MODE2		0x14
>  #define SYN_PS_CLIENT_CMD		0x28
>  
> -/* synaptics packet types */
> -#define SYN_NEWABS			0
> -#define SYN_NEWABS_STRICT		1
> -#define SYN_NEWABS_RELAXED		2
> -#define SYN_OLDABS			3
> -
>  /* amount to fuzz position data when touchpad reports reduced filtering */
>  #define SYN_REDUCED_FILTER_FUZZ		8
>  
> +/* synaptics packet types */
> +enum synaptics_pkt_type {
> +	SYN_NEWABS,
> +	SYN_NEWABS_STRICT,
> +	SYN_NEWABS_RELAXED,
> +	SYN_OLDABS,
> +};
> +
>  /*
>   * A structure to describe the state of the touchpad hardware (buttons and pad)
>   */
> @@ -159,8 +161,8 @@ struct synaptics_hw_state {
>  	unsigned int middle:1;
>  	unsigned int up:1;
>  	unsigned int down:1;
> -	unsigned char ext_buttons;
> -	signed char scroll;
> +	u8 ext_buttons;
> +	s8 scroll;
>  };
>  
>  /* Data read from the touchpad */
> @@ -181,8 +183,8 @@ struct synaptics_device_info {
>  struct synaptics_data {
>  	struct synaptics_device_info info;
>  
> -	unsigned char pkt_type;			/* packet type - old, new, etc */
> -	unsigned char mode;			/* current mode byte */
> +	enum synaptics_pkt_type pkt_type;	/* packet type - old, new, etc */
> +	u8 mode;				/* current mode byte */
>  	int scroll;
>  
>  	bool absolute_mode;			/* run in Absolute mode */
> -- 
> 2.12.1.578.ge9c3154ca4-goog
> 
