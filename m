From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] forced recalibration for the OLPC hgpk touchpad
Date: Wed, 3 Jun 2009 08:04:57 -0700
Message-ID: <200906030804.57340.dmitry.torokhov@gmail.com>
References: <3026.1243972079@foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758264AbZFCPFZ@vger.kernel.org>
In-Reply-To: <3026.1243972079@foxharp.boston.ma.us>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pgf@laptop.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Paul,

On Tuesday 02 June 2009 12:47:59 pgf@laptop.org wrote:
> The OLPC XO laptop incorporates a combination touchpad/tablet
> device which unfortunately requires frequent recalibration.  The
> driver will force this automatically when various suspicious
> behaviors are observed, and the user can recalibrate manually
> (with a special keyboard sequence).  There's currently no way,
> however, for an external program to cause recalibration.
>
> This patch creates a new node in /sys which, when written with '1',
> will force a touchpad recalibration.  No other writes (or reads)
> of this node are supported.
>


Instead of creating a new sysfs attribute maybe we should make
the touchpad recalibrate upon resume (reconnect)? Userspace can
already request reconnect via sysfs.
 
-- 
Dmitry
