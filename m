From: Paul Donohue <linux-kernel@paulsd.com>
Subject: Re: [PATCH 1/2] Fix V8 device information issue
Date: Tue, 14 Mar 2017 10:50:41 -0400
Message-ID: <20170314145041.GZ4609@TopQuark.net>
References: <20170314013413.7260-1-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170314013413.7260-1-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: dmitry.torokhov@gmail.com, nick.m.fletcher@gmail.com, joseph.salisbury@canonical.com, ben@smart-cactus.org, mhocko@suse.com, pali.rohar@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

On Tue, Mar 14, 2017 at 10:34:12AM +0900, Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> -Fix the issue that V8(E7=73 03 28) devices are not assined correct device information bit from OTP.
> -Specified correct OTP bit for the V8 device setting of Button pad, DualPoint and Touchpad size.
> -Deleted extra code from alps_v8_protocol_data decision process.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> 
> Acked-by: Pali Rohar <pali.rohar@gmail.com>

Tested-by: Paul Donohue <linux-kernel@PaulSD.com>
