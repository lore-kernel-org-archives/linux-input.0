From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Release device resource data obtained by
 devres_alloc()
Date: Wed, 25 Apr 2018 10:51:27 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1804251051200.28129@cbobk.fhfr.pm>
References: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 24 Apr 2018, Arvind Yadav wrote:

> Free device resource data, if __wacom_devm_sysfs_create_group
> is not successful.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
