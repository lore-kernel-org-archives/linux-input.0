From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] hidraw: Added Compatibility ioctl() for 32-bit applications.
Date: Tue, 4 Jan 2011 11:18:39 +0100
Message-ID: <201101041118.39602.arnd@arndb.de>
References: <1294119442-6827-1-git-send-email-alan@signal11.us> <1294119442-6827-2-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294119442-6827-2-git-send-email-alan@signal11.us>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, Antonio Ospite <ospite@studenti.unina.it>, Tejun Heo <tj@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tuesday 04 January 2011 06:37:22 Alan Ott wrote:
> Added the ioctl function to the compat_ioctl pointer in the
> file_operations struct. Before this, some ioctls would 
> fail for 32-bit apps on 64-bit systems.
> 
> Signed-off-by: Alan Ott <alan@signal11.us>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I verified that all the ioctls for hidraw are indeed compatible.

	Arnd
