From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] Bluetooth: hidp: Fix assumptions on the return value of hidp_send_message
Date: Mon, 23 Sep 2019 13:33:57 -0700
Message-ID: <20190923203357.8355-1-andrew.smirnov@gmail.com>
References: <3D70AB75-FEFB-4EB3-9AC8-3BCE90F5458D@holtmann.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3D70AB75-FEFB-4EB3-9AC8-3BCE90F5458D@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> I am taking this through my tree. And yes, I applied the updated patch, but answered the other ;)
>
> Regards
>
> Marcel

Are you also going to mark this patch for inclusion to stable tree? I haven't seen it in any of the stable queues (netdev, Greg's), so just wanted to check.

Thanks,
Andrey Smirnov
