From: Paul Donohue <linux-kernel@paulsd.com>
Subject: Re: [PATCH 2/2] Fix the issue that V8 Button pad Stick button does
 not work
Date: Tue, 14 Mar 2017 10:51:10 -0400
Message-ID: <20170314145110.GA4609@TopQuark.net>
References: <20170314013413.7260-1-masaki.ota@jp.alps.com>
 <20170314013413.7260-2-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170314013413.7260-2-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: dmitry.torokhov@gmail.com, nick.m.fletcher@gmail.com, joseph.salisbury@canonical.com, ben@smart-cactus.org, mhocko@suse.com, pali.rohar@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

On Tue, Mar 14, 2017 at 10:34:13AM +0900, Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - V8 Button pad Stick Right and Middle button don't work.
> - Alps stick devices have physical buttons absolutely, so delete "ALPS_BUTTONPAD" check Flag from Stick button process.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> 
> Acked-by: Pali Rohar <pali.rohar@gmail.com>

Tested-by: Paul Donohue <linux-kernel@PaulSD.com>
