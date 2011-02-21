From: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Subject: Re: [PATCH 2/2] bt hidp: send Output reports using SET_REPORT on  the Control channel
Date: Sun, 20 Feb 2011 22:45:36 -0500
Message-ID: <4D61DFE0.5020400@signal11.us>
References: <alpine.LNX.2.00.1102180944590.2160@pobox.suse.cz> <1298222806-19433-1-git-send-email-ospite@studenti.unina.it> <1298222806-19433-3-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298222806-19433-3-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, "Gustavo F. Padovan" <padovan-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, "pascal-dXI0m6hRz7k@public.gmane.org" <pascal-dXI0m6hRz7k@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 02/20/2011 12:26 PM, Antonio Ospite wrote:
> The current implementation of hidp_output_raw_report() relies only on
> the Control channel even for Output reports, and the BT HID
> specification [1] does not mention using the DATA message for Output
> reports on the Control channel (see section 7.9.1 and also Figure 11:
> SET_ Flow Chart), so let us just use SET_REPORT.
>
> This also fixes sending Output reports to some devices (like Sony
> Sixaxis) which are not able to handle DATA messages on the Control
> channel.
>
> Ideally hidp_output_raw_report() could be improved to use this scheme:
>    Feature Report -- SET_REPORT on the Control channel
>    Output Report  -- DATA on the Interrupt channel
> for more efficiency, but as said above, right now only the Control
> channel is used.
>
> [1] http://www.bluetooth.com/Specification%20Documents/HID_SPEC_V10.pdf
>
>   	case HID_OUTPUT_REPORT:
> -		report_type = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
> +		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;
>    

I think this is right. Section 7.4[.0] says that SET_ and GET_ requests 
return with HANDSHAKE. Section 7.4.9 says that DATA does _not_ return a 
HANDSHAKE. My patch to hidp_output_raw_report() relies on getting a 
HANDSHAKE back, so it wouldn't have worked with BT devices that take 
output reports. Since I don't have any that do, I couldn't test it. (And 
it was like that when I got here :) )

For the whole set:
Acked-by: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>

Alan.
